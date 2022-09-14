local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

local pfx = require("luasnip.extras.postfix").postfix
local matches = require("luasnip.extras.postfix").matches

local nl = function(text)
  local text = text or ""
  return t { "", text }
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function exec(_, command)
	local file = io.popen(command, "r")
	local res = {}
	for line in file:lines() do
		table.insert(res, line)
	end
	return res
end

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, snip, old_state, fmt)
	local fmt = fmt or "%Y-%m-%d"
	return sn(nil, i(1, os.date(fmt)))
end

local date_str = function(args, snip, old_state, fmt)
	local fmt = fmt or "%Y-%m-%d"
	return os.date(fmt)
end

local titlize = function(text)
  text = text or ""
  return text:gsub("%W%l", string.upper):gsub("^%l", string.upper):gsub("_", "")
end

local cls_name_input = function(args, snip)
  local name = snip.env.TM_FILENAME_BASE or "ClassName"
  return sn(nil, i(1, titlize(name)))
end

local titlize_capture = function(args, snip)
  local capture = snip.captures[1] or ""
  return sn(nil, i(1, titlize(capture)))
end

local titlize_capture_func = function(args, snip)
  return titlize(snip.captures[1])
end

local underscore_file_name = function(args, snip)
  return snip.env.TM_FILENAME:upper():gsub("[.]", "_")
end

local hide_snip = function() 
  return false
end

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_kv
rec_kv = function(args, _, old_state, separator)
  -- print(vim.inspect(separator))
  local separator = separator or ":"
  local sepNode = t('"' .. separator .. ' ')
	return sn(
		nil,
		c(1, {
			-- Order is important, sn(...) first would cause infinite loop of expansion.
			t(""),
      sn(nil, {
        sn(1, {
          t({ "", "\t" }), t('"'), i(1, 'key'), sepNode, i(2, "value"), t(","),
        }),
        d(2, rec_kv, {}, { user_args = {separator} }),
      }),
		})
	)
end

local rec_qlog
rec_qlog = function()
  return sn(nil, c(1, {
    t(";"),
    sn(nil, {
      sn(1, { t(" << "), t('"'), i(1), t('"'), }),
      d(2, rec_qlog, {}),
    }),
  }))
end

local rec_col
rec_col = function() 
  return sn(nil, c(1, {
    t(""),
    sn(nil, {
      sn(1, { t(" "), i(1), t("="), i(2, "?"), }),
      d(2, rec_col, {}),
    }),
  }))
end

-- local rec_task_context
-- rec_task_context = function()
--   return sn(nil, c(1, {
--     t(""),
--     sn(1, {
--       c(1, {
--           t(""),
--           sn(nil, {t("#context "), i(1), nl()}),
--           sn(nil, {
--             t("#time.start "), 
--             d(1, date_input),
--             nl(),
--           }),
--           sn(nil, {
--             t("#time.due "), 
--             d(1, date_input),
--             nl(),
--           }),
--         }), 
--       d(2, rec_task_context, {}),
--     })}))
-- end

-- duplicate string multiple times 
--  duplicate time is parsed from capture[1]
local dup = function(args, parent, str) 
  print(vim.inspect(parent.snippet.captures))
  local s = ''
  local count = tonumber(parent.snippet.captures[1])
  if count == nil then return str end
  for i=1,count do 
    s = s..str
  end
  return s
end

-- treesitter related helper functions 
local ts_utils = require'nvim-treesitter.ts_utils'
local my_ts_funcs = require'my_ts_funcs'
-- check if current node is string node
local function in_string_node()
  -- local query = [[
  -- (interpreted_string_literal) @cap
  -- ]]
  -- return my_ts_funcs.test_cur_node(query)
  --
  local node = ts_utils.get_node_at_cursor()
  while node do
    if node:type() == 'interpreted_string_literal' then
      return true
    end
    node = node:parent()
  end
  return false
end

-- SNIPPET DEFINATION 
ls.add_snippets(nil, {
  all = {
    s("Vin", {
      t("Vincent Wang"),
    }),
		s("novel", fmt([[
			It was a dark and stormy night on {} and the clocks were striking thirteen.
      ]], { d(1, date_input, {}, { user_args = {"%A, %B %d of %Y"} }) })
		),
    s({trig="dtime", name="YYYY-MM-DD"}, d(1, date_input, {}, { user_args = {"%B %d, %Y"} } )),
    s({trig="dtime2", name="Mon Day, Year"}, d(1, date_input, {}, { user_args = {"%B %d, %Y"} } )),
    s({trig="dtime3", name="ISO8601: 2022-05-02T03:58:30Z"}, d(1, date_input, {}, { user_args = {"!%Y-%m-%dT%TZ"} } )),
    s("section", fmt(
      [[
      ////////////////////////////////////////////////////////////////
      // {}
      ////////////////////////////////////////////////////////////////

      ]], 
      i(1))
    ),
		-- Set store_selection_keys = "<Tab>" (for example) in your
		-- luasnip.config.setup() call to populate
		-- TM_SELECTED_TEXT/SELECT_RAW/SELECT_DEDENT.
		-- In this case: select a URL, hit Tab, then expand this snippet.
		s("link_url", fmt( [[<a href="{}">{}</a>]], 
      {
        i(1),
        f(function(_, snip)
          -- TM_SELECTED_TEXT is a table to account for multiline-selections.
          -- In this case only the first line is inserted.
          return snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
      })
    ),
    pfx('."', {
      l('"' .. l.POSTFIX_MATCH .. '" '),
    }),
    pfx(".'", {
      l("'" .. l.POSTFIX_MATCH .. "' "),
    }),
    pfx(".*", {
      l("*" .. l.POSTFIX_MATCH .. "* "),
    }),
    pfx(".(", {
      l("(" .. l.POSTFIX_MATCH .. ") "),
    }),
    pfx(".[", {
      l('[' .. l.POSTFIX_MATCH .. '] '),
    }),
    pfx(".{", {
      l('{' .. l.POSTFIX_MATCH .. '} '),
    }),
    pfx(".up", {
      l(l.POSTFIX_MATCH:upper()),
    }),
    pfx(".lo", {
      l(l.POSTFIX_MATCH:lower()),
    }),
  },
  vim = {
    s("conf", fmta(
      [[
      " <> {{{1
      <>
      " }}}1
      <>
      ]],
      { i(1, "SCRIPT_NAME"), i(2), i(0) })
    ),
  },
  go = {
    s("logws", {
      t("log.WithFields(log.Fields{"),
      sn(1, {
        t({ "", "\t" }), t('"'), i(1, 'key'), t('": '), i(2, "value"), t(","),
      }),
			d(2, rec_kv, {}), -- repeat key-value pair
      nl("})."),
      c(3, {
        t("Info"), t("Error"), t("Warn"), t("Debug"),
        t("Panic"), t("Fatal"), t("Trace"),
      }),
      t('("'), i(0), t('")'), nl(),
    }),
    s("logw", fmt([[log.WithField("{}", {}).{}("{}")]], 
      { i(1, "error"), i(2, "err"), 
        c(3, {
          t("Info"), t("Warn"), t("Error"), t("Debug"),
          t("Panic"), t("Fatal"), t("Trace"),
        }),
        i(0) })
    ),
    s("loge", fmt([[log.WithError(err).{}("{}")]], {
      c(1, {
        t("Error"), t("Warn"), t("Info"), t("Debug"),
        t("Panic"), t("Fatal"), t("Trace"),
      }),
      i(0),
    })),
    s("retnil", {
      t("return nil"),
      c(1, {
        sn(nil, {
          t(", "),
          i(nil, "")
        }),
        t(""),
      }),
      i(0)
    }),
    s("iferr", fmta([[
    if err != nil {
      <>
      return 
    }
    ]], {
      i(1)
    })),
    s("err", fmt([[
    err = fmt.Errorf("{}")
    ]], { i(1) }),
      { 
        condition = function(line_to_cursor, matched_trigger, captures)
					return not in_string_node()
          -- return line_to_cursor:match("^%s*err")
        end,
      }
    ),
  },
  cpp = {
    s("del", fmta(
      [[
      if (<> != NULL) {
        delete <>; 
        <> = NULL;
      }
    
      ]], 
      { i(1, "POINTER"), rep(1), rep(1) })
    ),
    s("once", fmt(
      [[
      #ifndef __{file_name}__
      #define __{file_name}__

      {1}

      #endif /* __{file_name}__ */
      ]], 
    {
      i(1),
			file_name = f(underscore_file_name),
    })),
    s("qlog", fmt(
    [[
      QLOG_{}() << "{}"{}
    ]], {
        c(1, {
          t("INFO"), t("WARN"), t("ERROR"), t("FATAL"), t("DEBUG"), t("TRACE"),
        }),
        i(2),
        d(3, rec_qlog, {})
      })
    ),
    s("qconn", fmt([[
      connect({}, SIGNAL({}({})), 
        {},  SLOT(on{}({})));
      ]], {
        i(1, "SOURCE"),
        i(2, "SIGNAL_NAME"),
        i(3, "PARAMS"),
        i(4, "this"),
        -- generate signal handler's name: from 'click' to 'onClick'
        l(l._1:gsub("%W%l", string.upper):gsub("^%l", string.upper), 2),
        rep(3),
      })
    ),
    s("qtmain", 
      fmt(
        [[
        #include <QtCore/QCoreApplication>

        int main(int argc, char *argv[])
        {{,
          QCoreApplication a(argc, argv);
          {} 
        }}
        ]], i(1))
    ),
    s("qclass", fmta([[
      class <>: <> <>
      {
        Q_OBJECT
      public:
        explicit <>(<> * parent=NULL);
        virtual ~<>();

        <>

      signals:

      private slots:

      private:

      };

      ]],
      {
        d(1, cls_name_input, {}),
        c(2, {
          t("public"),
          t("protected"),
          t("private"),
        }),
        i(3, "QObject"),
        rep(1),
        rep(3),
        rep(1),
        i(4),
      })
    ),
    s("istringlist", t("#include <QtCore/QStringList>")),
    s("ibytearray", t("#include <QtCore/QByteArray>")),
    -- "icfile" => "#include <QtCore/QFile>"
    s({trig="ic(%w+)", regTrig = true}, {
      t("#include <QtCore/Q"),
      d(1, titlize_capture, {}),
      -- f(titlize_capture_func, {}),
      t(">"),
    }, {
      show_condition = hide_snip,
    }),
    -- "igframe" => "#include <QtGui/QFrame>"
    s({trig="ig(%w+)", regTrig = true}, {
      t("#include <QtGui/Q"),
      d(1, titlize_capture, {}),
      -- f(titlize_capture_func, {}),
      t(">"),
    }, {
      show_condition = hide_snip,
    }),
    -- tr works when pre-selected text exists or not
    s("tr", {
      t('tr("'),
      d(1, function(_, snip)
        -- get pre-selected text
        local selected = snip.env.TM_SELECTED_TEXT[1] or ""
        return sn(nil, {
          -- allow edit when nothing pre-selected yet
          #selected == 0 and i(1, selected) or t(selected)
        })
      end, {}),
      t('")'),
    })
  },
  php = {
    s("array", fmt("array({})", d(1, rec_kv, {}, { user_args = {" => "} })) ),
    s("L", fmt("L({})",
			f(function(_, snip)
				return snip.env.TM_SELECTED_TEXT[1] or {}
			end, {}))
    ),
  },
  javascript = {
  },
  vue = {
  },
  sql = {
    s({trig="sel", wordTrig=true, name="select sql statement"}, {
      t("SELECT "),
      i(1, "*"),
      t(" FROM "),
      i(2),
      c(3, {
        sn(nil, {
          t(" WHERE "), i(1), t(";"),
        }),
        t(";"),
      }),
    }),
    s({trig="del", wordTrig=true, name="delete sql statement"}, fmt([[
      DELETE FROM {} WHERE {} ;
      ]],
      {
        i(1),
        i(2),
      }) 
    ),
    s({trig="upd", wordTrig=true, name="update sql statement"}, fmt([[
      UPDATE {} SET {} WHERE {} ;
      ]], {
        i(1),
        i(2),
        i(3),
      })
    ),
  },
  norg = {
    s("#ts", fmt("#time.start {}{}", 
      { f(date_str), i(0)})
    ),
    s("#td", fmt("#time.due {}{}", 
      { f(date_str), i(0)})
    ),
    s("#ctx", fmt("#context {}", i(0))),
    s({trig="t(%d?)", regTrig = true}, fmt([[
      {}{} [ ] {}
      ]], 
      { 
        c(1, {
          t(""),
          sn(nil, {
            t("#context "), 
            i(1), 
            t({"", ""})
          }),
          sn(nil, {
            t("#time.start "), 
            d(1, date_input),
            i(2),
            t({"", ""})
          }),
          sn(nil, {
            t("#time.due "), 
            d(1, date_input),
            i(2),
            t({"", ""})
          }),
        }), 
			  -- d(1, rec_task_context, {}), -- repeat task context 

        f(dup, {}, { user_args = {"-"} }), 
        i(0) 
      } )
    ),
    s({trig="h(%d?)", regTrig = true}, fmt("{} {}", 
      { f(dup, {}, { user_args = {"*"} }), i(0)})
    ),
    pfx({trig="t1", match_pattern=matches.line}, {
      l("- [ ] " .. l.POSTFIX_MATCH),
    }),
  },
})

-- mix/reuse snippets
ls.filetype_extend("vue", {"javascript"})
ls.filetype_extend("go", {"sql"})
ls.filetype_extend("php", {"sql"})

-- ls.add_snippets(nil,  {
-- 	all = {
-- 		s("autotrig", {
-- 			t("autosnippet"),
-- 		}),
-- 	},
-- }, {type = "autosnippets"})

--[[
-- Beside defining your own snippets you can also load snippets from "vscode-like" packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
-- Mind that this will extend  `ls.snippets` so you need to do it after your own snippets or you
-- will need to extend the table yourself instead of setting a new one.
]]

require("luasnip.loaders.from_vscode").lazy_load({
  include = { "go", "sql", "cpp", "php", "javascript", "vue"},
})
