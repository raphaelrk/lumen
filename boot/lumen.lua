(function ()
  nexus = {}
end)();
(function ()
  local function nil63(x)
    return((x == nil))
  end
  local function is63(x)
    return((not nil63(x)))
  end
  local function length(x)
    return(#x)
  end
  local function none63(x)
    return((length(x) == 0))
  end
  local function some63(x)
    return((length(x) > 0))
  end
  local function hd(l)
    return(l[1])
  end
  local function string63(x)
    return((type(x) == "string"))
  end
  local function number63(x)
    return((type(x) == "number"))
  end
  local function boolean63(x)
    return((type(x) == "boolean"))
  end
  local function function63(x)
    return((type(x) == "function"))
  end
  local function composite63(x)
    return((type(x) == "table"))
  end
  local function atom63(x)
    return((not composite63(x)))
  end
  local function table63(x)
    return((composite63(x) and nil63(hd(x))))
  end
  local function list63(x)
    return((composite63(x) and is63(hd(x))))
  end
  local function substring(str, from, upto)
    return((string.sub)(str, (from + 1), upto))
  end
  local function sublist(l, from, upto)
    local i = (from or 0)
    local j = 0
    local _g21 = (upto or length(l))
    local l2 = {}
    while (i < _g21) do
      l2[(j + 1)] = l[(i + 1)]
      i = (i + 1)
      j = (j + 1)
    end
    return(l2)
  end
  local function sub(x, from, upto)
    local _g22 = (from or 0)
    if string63(x) then
      return(substring(x, _g22, upto))
    else
      local l = sublist(x, _g22, upto)
      local _g23 = x
      local k = nil
      for k in next, _g23 do
        if (not number63(k)) then
          local v = _g23[k]
          l[k] = v
        end
      end
      return(l)
    end
  end
  local function inner(x)
    return(sub(x, 1, (length(x) - 1)))
  end
  local function tl(l)
    return(sub(l, 1))
  end
  local function char(str, n)
    return(sub(str, n, (n + 1)))
  end
  local function code(str, n)
    local _g24
    if n then
      _g24 = (n + 1)
    end
    return((string.byte)(str, _g24))
  end
  local function string_literal63(x)
    return((string63(x) and (char(x, 0) == "\"")))
  end
  local function id_literal63(x)
    return((string63(x) and (char(x, 0) == "|")))
  end
  local function add(l, x)
    return((table.insert)(l, x))
  end
  local function drop(l)
    return((table.remove)(l))
  end
  local function last(l)
    return(l[((length(l) - 1) + 1)])
  end
  local function reverse(l)
    local l1 = sub(l, length(l))
    local i = (length(l) - 1)
    while (i >= 0) do
      add(l1, l[(i + 1)])
      i = (i - 1)
    end
    return(l1)
  end
  local function join(l1, l2)
    if (nil63(l2) and nil63(l1)) then
      return({})
    else
      if nil63(l1) then
        return(join({}, l2))
      else
        if nil63(l2) then
          return(join(l1, {}))
        else
          local l = {}
          local skip63 = false
          if (not skip63) then
            local i = 0
            local len = length(l1)
            while (i < len) do
              l[(i + 1)] = l1[(i + 1)]
              i = (i + 1)
            end
            while (i < (len + length(l2))) do
              l[(i + 1)] = l2[((i - len) + 1)]
              i = (i + 1)
            end
          end
          local _g25 = l1
          local k = nil
          for k in next, _g25 do
            if (not number63(k)) then
              local v = _g25[k]
              l[k] = v
            end
          end
          local _g26 = l2
          local k = nil
          for k in next, _g26 do
            if (not number63(k)) then
              local v = _g26[k]
              l[k] = v
            end
          end
          return(l)
        end
      end
    end
  end
  local function reduce(f, x)
    if none63(x) then
      return(x)
    else
      if (length(x) == 1) then
        return(hd(x))
      else
        return(f(hd(x), reduce(f, tl(x))))
      end
    end
  end
  local function keep(f, l)
    local l1 = {}
    local _g27 = l
    local _g28 = 0
    while (_g28 < length(_g27)) do
      local x = _g27[(_g28 + 1)]
      if f(x) then
        add(l1, x)
      end
      _g28 = (_g28 + 1)
    end
    return(l1)
  end
  local function find(f, l)
    local _g29 = l
    local _g30 = 0
    while (_g30 < length(_g29)) do
      local x = _g29[(_g30 + 1)]
      local _g31 = f(x)
      if _g31 then
        return(_g31)
      end
      _g30 = (_g30 + 1)
    end
  end
  local function pairwise(l)
    local i = 0
    local l1 = {}
    while (i < length(l)) do
      add(l1, {l[(i + 1)], l[((i + 1) + 1)]})
      i = (i + 2)
    end
    return(l1)
  end
  local function iterate(f, count)
    local i = 0
    while (i < count) do
      f(i)
      i = (i + 1)
    end
  end
  local function replicate(n, x)
    local l = {}
    iterate(function ()
      return(add(l, x))
    end, n)
    return(l)
  end
  local function splice(x)
    return({_splice = true, value = x})
  end
  local function splice63(x)
    return((table63(x) and x._splice))
  end
  local function mapl(f, l)
    local l1 = {}
    local _g32 = l
    local _g33 = 0
    while (_g33 < length(_g32)) do
      local x = _g32[(_g33 + 1)]
      local _g34 = f(x)
      if splice63(_g34) then
        l1 = join(l1, _g34.value)
      else
        if is63(_g34) then
          add(l1, _g34)
        end
      end
      _g33 = (_g33 + 1)
    end
    return(l1)
  end
  local function map(f, t)
    local l = mapl(f, t)
    local _g35 = t
    local k = nil
    for k in next, _g35 do
      if (not number63(k)) then
        local v = _g35[k]
        local x = f(v)
        if splice63(x) then
          l[k] = x.value
        else
          if is63(x) then
            l[k] = x
          end
        end
      end
    end
    return(l)
  end
  local function keys63(t)
    local k63 = false
    local _g36 = t
    local k = nil
    for k in next, _g36 do
      if (not number63(k)) then
        local v = _g36[k]
        k63 = true
        break
      end
    end
    return(k63)
  end
  local function empty63(t)
    return((none63(t) and (not keys63(t))))
  end
  local function stash(args)
    if keys63(args) then
      local p = {_stash = true}
      local _g37 = args
      local k = nil
      for k in next, _g37 do
        if (not number63(k)) then
          local v = _g37[k]
          p[k] = v
        end
      end
      return(join(args, {p}))
    else
      return(args)
    end
  end
  local function unstash(args)
    if none63(args) then
      return({})
    else
      local l = last(args)
      if (table63(l) and l._stash) then
        local args1 = sub(args, 0, (length(args) - 1))
        local _g38 = l
        local k = nil
        for k in next, _g38 do
          if (not number63(k)) then
            local v = _g38[k]
            if (k ~= "_stash") then
              args1[k] = v
            end
          end
        end
        return(args1)
      else
        return(args)
      end
    end
  end
  local function extend(t, ...)
    local xs = unstash({...})
    local _g39 = sub(xs, 0)
    return(join(t, _g39))
  end
  local function exclude(t, ...)
    local keys = unstash({...})
    local _g40 = sub(keys, 0)
    local t1 = sublist(t)
    local _g41 = t
    local k = nil
    for k in next, _g41 do
      if (not number63(k)) then
        local v = _g41[k]
        if (not _g40[k]) then
          t1[k] = v
        end
      end
    end
    return(t1)
  end
  local function search(str, pattern, start)
    local _g43
    if start then
      _g43 = (start + 1)
    end
    local _g42 = _g43
    local i = (string.find)(str, pattern, start, true)
    return((i and (i - 1)))
  end
  local function split(str, sep)
    if ((str == "") or (sep == "")) then
      return({})
    else
      local strs = {}
      while true do
        local i = search(str, sep)
        if nil63(i) then
          break
        else
          add(strs, sub(str, 0, i))
          str = sub(str, (i + 1))
        end
      end
      add(strs, str)
      return(strs)
    end
  end
  local function cat(...)
    local xs = unstash({...})
    local _g44 = sub(xs, 0)
    if none63(_g44) then
      return("")
    else
      return(reduce(function (a, b)
        return((a .. b))
      end, _g44))
    end
  end
  local function _43(...)
    local xs = unstash({...})
    local _g45 = sub(xs, 0)
    return(reduce(function (a, b)
      return((a + b))
    end, _g45))
  end
  local function _(...)
    local xs = unstash({...})
    local _g46 = sub(xs, 0)
    return(reduce(function (a, b)
      return((b - a))
    end, reverse(_g46)))
  end
  local function _42(...)
    local xs = unstash({...})
    local _g47 = sub(xs, 0)
    return(reduce(function (a, b)
      return((a * b))
    end, _g47))
  end
  local function _47(...)
    local xs = unstash({...})
    local _g48 = sub(xs, 0)
    return(reduce(function (a, b)
      return((b / a))
    end, reverse(_g48)))
  end
  local function _37(...)
    local xs = unstash({...})
    local _g49 = sub(xs, 0)
    return(reduce(function (a, b)
      return((b % a))
    end, reverse(_g49)))
  end
  local function _62(a, b)
    return((a > b))
  end
  local function _60(a, b)
    return((a < b))
  end
  local function _61(a, b)
    return((a == b))
  end
  local function _6261(a, b)
    return((a >= b))
  end
  local function _6061(a, b)
    return((a <= b))
  end
  local function read_file(path)
    local f = (io.open)(path)
    return((f.read)(f, "*a"))
  end
  local function write_file(path, data)
    local f = (io.open)(path, "w")
    return((f.write)(f, data))
  end
  local function write(x)
    return((io.write)(x))
  end
  local function exit(code)
    return((os.exit)(code))
  end
  local function parse_number(str)
    return(tonumber(str))
  end
  local function to_string(x)
    if nil63(x) then
      return("nil")
    else
      if boolean63(x) then
        if x then
          return("true")
        else
          return("false")
        end
      else
        if function63(x) then
          return("#<function>")
        else
          if atom63(x) then
            return((x .. ""))
          else
            local str = "("
            local x1 = sub(x)
            local _g50 = x
            local k = nil
            for k in next, _g50 do
              if (not number63(k)) then
                local v = _g50[k]
                add(x1, (k .. ":"))
                add(x1, v)
              end
            end
            local _g51 = x1
            local i = 0
            while (i < length(_g51)) do
              local y = _g51[(i + 1)]
              str = (str .. to_string(y))
              if (i < (length(x1) - 1)) then
                str = (str .. " ")
              end
              i = (i + 1)
            end
            return((str .. ")"))
          end
        end
      end
    end
  end
  local function apply(f, args)
    local _g52 = stash(args)
    return(f(unpack(_g52)))
  end
  local id_count = 0
  local function make_id()
    id_count = (id_count + 1)
    return(("_g" .. id_count))
  end
  local function _37message_handler(msg)
    local i = search(msg, ": ")
    return(sub(msg, (i + 2)))
  end
  local function toplevel63()
    return((length(environment) == 1))
  end
  local function module_key(spec)
    if atom63(spec) then
      return(to_string(spec))
    else
      error("Unsupported module specification")
    end
  end
  local function module(spec)
    return(modules[module_key(spec)])
  end
  local function setenv(k, ...)
    local keys = unstash({...})
    local _g53 = sub(keys, 0)
    if string63(k) then
      local frame = last(environment)
      local x = (frame[k] or {})
      local _g54 = _g53
      local k1 = nil
      for k1 in next, _g54 do
        if (not number63(k1)) then
          local v = _g54[k1]
          x[k1] = v
        end
      end
      if toplevel63() then
        local m = module(current_module)
        m.export[k] = x
      end
      frame[k] = x
    end
  end
  local _g55 = {}
  nexus.runtime = _g55
  _g55["nil?"] = nil63
  _g55["is?"] = is63
  _g55.length = length
  _g55["none?"] = none63
  _g55["some?"] = some63
  _g55.hd = hd
  _g55["string?"] = string63
  _g55["number?"] = number63
  _g55["boolean?"] = boolean63
  _g55["function?"] = function63
  _g55["composite?"] = composite63
  _g55["atom?"] = atom63
  _g55["table?"] = table63
  _g55["list?"] = list63
  _g55.substring = substring
  _g55.sublist = sublist
  _g55.sub = sub
  _g55.inner = inner
  _g55.tl = tl
  _g55.char = char
  _g55.code = code
  _g55["string-literal?"] = string_literal63
  _g55["id-literal?"] = id_literal63
  _g55.add = add
  _g55.drop = drop
  _g55.last = last
  _g55.reverse = reverse
  _g55.join = join
  _g55.reduce = reduce
  _g55.keep = keep
  _g55.find = find
  _g55.pairwise = pairwise
  _g55.iterate = iterate
  _g55.replicate = replicate
  _g55.splice = splice
  _g55.map = map
  _g55["keys?"] = keys63
  _g55["empty?"] = empty63
  _g55.stash = stash
  _g55.unstash = unstash
  _g55.extend = extend
  _g55.exclude = exclude
  _g55.search = search
  _g55.split = split
  _g55.cat = cat
  _g55["+"] = _43
  _g55["-"] = _
  _g55["*"] = _42
  _g55["/"] = _47
  _g55["%"] = _37
  _g55[">"] = _62
  _g55["<"] = _60
  _g55["="] = _61
  _g55[">="] = _6261
  _g55["<="] = _6061
  _g55["read-file"] = read_file
  _g55["write-file"] = write_file
  _g55.write = write
  _g55.exit = exit
  _g55["parse-number"] = parse_number
  _g55["to-string"] = to_string
  _g55.apply = apply
  _g55["make-id"] = make_id
  _g55["%message-handler"] = _37message_handler
  _g55["toplevel?"] = toplevel63
  _g55["module-key"] = module_key
  _g55.module = module
  _g55.setenv = setenv
  _g55["splice?"] = splice63
  _g55.mapl = mapl
  _g55["id-count"] = id_count
end)();
(function ()
  local _g60 = nexus.runtime
  local nil63 = _g60["nil?"]
  local is63 = _g60["is?"]
  local length = _g60.length
  local none63 = _g60["none?"]
  local some63 = _g60["some?"]
  local hd = _g60.hd
  local string63 = _g60["string?"]
  local number63 = _g60["number?"]
  local boolean63 = _g60["boolean?"]
  local function63 = _g60["function?"]
  local composite63 = _g60["composite?"]
  local atom63 = _g60["atom?"]
  local table63 = _g60["table?"]
  local list63 = _g60["list?"]
  local substring = _g60.substring
  local sublist = _g60.sublist
  local sub = _g60.sub
  local inner = _g60.inner
  local tl = _g60.tl
  local char = _g60.char
  local code = _g60.code
  local string_literal63 = _g60["string-literal?"]
  local id_literal63 = _g60["id-literal?"]
  local add = _g60.add
  local drop = _g60.drop
  local last = _g60.last
  local reverse = _g60.reverse
  local join = _g60.join
  local reduce = _g60.reduce
  local keep = _g60.keep
  local find = _g60.find
  local pairwise = _g60.pairwise
  local iterate = _g60.iterate
  local replicate = _g60.replicate
  local splice = _g60.splice
  local map = _g60.map
  local keys63 = _g60["keys?"]
  local empty63 = _g60["empty?"]
  local stash = _g60.stash
  local unstash = _g60.unstash
  local extend = _g60.extend
  local exclude = _g60.exclude
  local search = _g60.search
  local split = _g60.split
  local cat = _g60.cat
  local _43 = _g60["+"]
  local _ = _g60["-"]
  local _42 = _g60["*"]
  local _47 = _g60["/"]
  local _37 = _g60["%"]
  local _62 = _g60[">"]
  local _60 = _g60["<"]
  local _61 = _g60["="]
  local _6261 = _g60[">="]
  local _6061 = _g60["<="]
  local read_file = _g60["read-file"]
  local write_file = _g60["write-file"]
  local write = _g60.write
  local exit = _g60.exit
  local parse_number = _g60["parse-number"]
  local to_string = _g60["to-string"]
  local apply = _g60.apply
  local make_id = _g60["make-id"]
  local _37message_handler = _g60["%message-handler"]
  local toplevel63 = _g60["toplevel?"]
  local module_key = _g60["module-key"]
  local module = _g60.module
  local setenv = _g60.setenv
  local function getenv(k, ...)
    local keys = unstash({...})
    local _g63 = sub(keys, 0)
    if string63(k) then
      local b = find(function (e)
        return(e[k])
      end, reverse(environment))
      if table63(b) then
        local _g64 = nil
        local _g65 = _g63
        local x = nil
        for x in next, _g65 do
          if (not number63(x)) then
            local _g56 = _g65[x]
            _g64 = x
          end
        end
        if _g64 then
          return(b[_g64])
        else
          return(b)
        end
      end
    end
  end
  local function macro_function(k)
    return(getenv(k, {_stash = true, macro = true}))
  end
  local function macro63(k)
    return(is63(macro_function(k)))
  end
  local function special63(k)
    return(is63(getenv(k, {_stash = true, special = true})))
  end
  local function special_form63(form)
    return((list63(form) and special63(hd(form))))
  end
  local function statement63(k)
    return((special63(k) and getenv(k, {_stash = true, stmt = true})))
  end
  local function symbol_expansion(k)
    return(getenv(k, {_stash = true, symbol = true}))
  end
  local function symbol63(k)
    return(is63(symbol_expansion(k)))
  end
  local function variable63(k)
    local b = find(function (frame)
      return((frame[k] or frame._scope))
    end, reverse(environment))
    return((table63(b) and is63(b.variable)))
  end
  local function global63(k)
    return(getenv(k, {_stash = true, global = true}))
  end
  local function bound63(x)
    return((macro63(x) or special63(x) or symbol63(x) or variable63(x) or global63(x)))
  end
  local function escape(str)
    local str1 = "\""
    local i = 0
    while (i < length(str)) do
      local c = char(str, i)
      local _g66
      if (c == "\n") then
        _g66 = "\\n"
      else
        local _g67
        if (c == "\"") then
          _g67 = "\\\""
        else
          local _g68
          if (c == "\\") then
            _g68 = "\\\\"
          else
            _g68 = c
          end
          _g67 = _g68
        end
        _g66 = _g67
      end
      local c1 = _g66
      str1 = (str1 .. c1)
      i = (i + 1)
    end
    return((str1 .. "\""))
  end
  local function quoted(form)
    if string63(form) then
      return(escape(form))
    else
      if atom63(form) then
        return(form)
      else
        return(join({"list"}, map(quoted, form)))
      end
    end
  end
  local function stash42(args)
    if keys63(args) then
      local l = {"%object", "_stash", true}
      local _g69 = args
      local k = nil
      for k in next, _g69 do
        if (not number63(k)) then
          local v = _g69[k]
          add(l, k)
          add(l, v)
        end
      end
      return(join(args, {l}))
    else
      return(args)
    end
  end
  local function bind(lh, rh)
    if (composite63(lh) and list63(rh)) then
      local id = make_id()
      return(join({{id, rh}}, bind(lh, id)))
    else
      if atom63(lh) then
        return({{lh, rh}})
      else
        local bs = {}
        local r = lh.rest
        local _g70 = lh
        local i = 0
        while (i < length(_g70)) do
          local x = _g70[(i + 1)]
          bs = join(bs, bind(x, {"at", rh, i}))
          i = (i + 1)
        end
        if r then
          bs = join(bs, bind(r, {"sub", rh, length(lh)}))
        end
        local _g71 = lh
        local k = nil
        for k in next, _g71 do
          if (not number63(k)) then
            local v = _g71[k]
            if (v == true) then
              v = k
            end
            if (k ~= "rest") then
              bs = join(bs, bind(v, {"get", rh, {"quote", k}}))
            end
          end
        end
        return(bs)
      end
    end
  end
  local function bind42(args, body)
    local args1 = {}
    local function rest()
      if (target == "js") then
        return({"unstash", {"sublist", "arguments", length(args1)}})
      else
        add(args1, "|...|")
        return({"unstash", {"list", "|...|"}})
      end
    end
    if atom63(args) then
      return({args1, {join({"let", {args, rest()}}, body)}})
    else
      local bs = {}
      local r = (args.rest or (keys63(args) and make_id()))
      local _g72 = args
      local _g73 = 0
      while (_g73 < length(_g72)) do
        local arg = _g72[(_g73 + 1)]
        if atom63(arg) then
          add(args1, arg)
        else
          if (list63(arg) or keys63(arg)) then
            local v = make_id()
            add(args1, v)
            bs = join(bs, {arg, v})
          end
        end
        _g73 = (_g73 + 1)
      end
      if r then
        bs = join(bs, {r, rest()})
      end
      if keys63(args) then
        bs = join(bs, {sub(args, length(args)), r})
      end
      if none63(bs) then
        return({args1, body})
      else
        return({args1, {join({"let", bs}, body)}})
      end
    end
  end
  local function quoting63(depth)
    return(number63(depth))
  end
  local function quasiquoting63(depth)
    return((quoting63(depth) and (depth > 0)))
  end
  local function can_unquote63(depth)
    return((quoting63(depth) and (depth == 1)))
  end
  local function quasisplice63(x, depth)
    return((list63(x) and can_unquote63(depth) and (hd(x) == "unquote-splicing")))
  end
  local function macroexpand(form)
    if symbol63(form) then
      return(macroexpand(symbol_expansion(form)))
    else
      if atom63(form) then
        return(form)
      else
        local x = hd(form)
        if (x == "%function") then
          local _g57 = form[1]
          local args = form[2]
          local body = sub(form, 2)
          add(environment, {_scope = true})
          local _g76 = args
          local _g77 = 0
          while (_g77 < length(_g76)) do
            local _g74 = _g76[(_g77 + 1)]
            setenv(_g74, {_stash = true, variable = true})
            _g77 = (_g77 + 1)
          end
          local _g75 = join({"%function", map(macroexpand, args)}, macroexpand(body))
          drop(environment)
          return(_g75)
        else
          if ((x == "%local-function") or (x == "%global-function")) then
            local _g58 = form[1]
            local name = form[2]
            local _g78 = form[3]
            local _g79 = sub(form, 3)
            add(environment, {_scope = true})
            local _g82 = _g78
            local _g83 = 0
            while (_g83 < length(_g82)) do
              local _g80 = _g82[(_g83 + 1)]
              setenv(_g80, {_stash = true, variable = true})
              _g83 = (_g83 + 1)
            end
            local _g81 = join({x, name, map(macroexpand, _g78)}, macroexpand(_g79))
            drop(environment)
            return(_g81)
          else
            if macro63(x) then
              return(macroexpand(apply(macro_function(x), tl(form))))
            else
              return(map(macroexpand, form))
            end
          end
        end
      end
    end
  end
  local quasiexpand
  local quasiquote_list
  quasiquote_list = function (form, depth)
    local xs = {{"list"}}
    local _g84 = form
    local k = nil
    for k in next, _g84 do
      if (not number63(k)) then
        local v = _g84[k]
        local _g89
        if quasisplice63(v, depth) then
          _g89 = quasiexpand(v[2])
        else
          _g89 = quasiexpand(v, depth)
        end
        local _g85 = _g89
        last(xs)[k] = _g85
      end
    end
    local _g86 = form
    local _g87 = 0
    while (_g87 < length(_g86)) do
      local x = _g86[(_g87 + 1)]
      if quasisplice63(x, depth) then
        local _g88 = quasiexpand(x[2])
        add(xs, _g88)
        add(xs, {"list"})
      else
        add(last(xs), quasiexpand(x, depth))
      end
      _g87 = (_g87 + 1)
    end
    local pruned = keep(function (x)
      return(((length(x) > 1) or (not (hd(x) == "list")) or keys63(x)))
    end, xs)
    return(join({"join*"}, pruned))
  end
  quasiexpand = function (form, depth)
    if quasiquoting63(depth) then
      if atom63(form) then
        return({"quote", form})
      else
        if (can_unquote63(depth) and (hd(form) == "unquote")) then
          return(quasiexpand(form[2]))
        else
          if ((hd(form) == "unquote") or (hd(form) == "unquote-splicing")) then
            return(quasiquote_list(form, (depth - 1)))
          else
            if (hd(form) == "quasiquote") then
              return(quasiquote_list(form, (depth + 1)))
            else
              return(quasiquote_list(form, depth))
            end
          end
        end
      end
    else
      if atom63(form) then
        return(form)
      else
        if (hd(form) == "quote") then
          return(form)
        else
          if (hd(form) == "quasiquote") then
            return(quasiexpand(form[2], 1))
          else
            return(map(function (x)
              return(quasiexpand(x, depth))
            end, form))
          end
        end
      end
    end
  end
  indent_level = 0
  local function indentation()
    return(apply(cat, replicate(indent_level, "  ")))
  end
  local reserved = {["="] = true, ["=="] = true, ["+"] = true, ["-"] = true, ["%"] = true, ["*"] = true, ["/"] = true, ["<"] = true, [">"] = true, ["<="] = true, [">="] = true, ["break"] = true, ["case"] = true, ["catch"] = true, ["continue"] = true, ["debugger"] = true, ["default"] = true, ["delete"] = true, ["do"] = true, ["else"] = true, ["finally"] = true, ["for"] = true, ["function"] = true, ["if"] = true, ["in"] = true, ["instanceof"] = true, ["new"] = true, ["return"] = true, ["switch"] = true, ["this"] = true, ["throw"] = true, ["try"] = true, ["typeof"] = true, ["var"] = true, ["void"] = true, ["with"] = true, ["and"] = true, ["end"] = true, ["repeat"] = true, ["while"] = true, ["false"] = true, ["local"] = true, ["nil"] = true, ["then"] = true, ["not"] = true, ["true"] = true, ["elseif"] = true, ["or"] = true, ["until"] = true}
  local function reserved63(x)
    return(reserved[x])
  end
  local function numeric63(n)
    return(((n > 47) and (n < 58)))
  end
  local function valid_char63(n)
    return((numeric63(n) or ((n > 64) and (n < 91)) or ((n > 96) and (n < 123)) or (n == 95)))
  end
  local function valid_id63(id)
    if none63(id) then
      return(false)
    else
      if special63(id) then
        return(false)
      else
        if reserved63(id) then
          return(false)
        else
          local i = 0
          while (i < length(id)) do
            local n = code(id, i)
            local valid63 = valid_char63(n)
            if ((not valid63) or ((i == 0) and numeric63(n))) then
              return(false)
            end
            i = (i + 1)
          end
          return(true)
        end
      end
    end
  end
  local function to_id(id)
    local id1 = ""
    local i = 0
    while (i < length(id)) do
      local c = char(id, i)
      local n = code(c)
      local _g94
      if (c == "-") then
        _g94 = "_"
      else
        local _g95
        if valid_char63(n) then
          _g95 = c
        else
          local _g96
          if (i == 0) then
            _g96 = ("_" .. n)
          else
            _g96 = n
          end
          _g95 = _g96
        end
        _g94 = _g95
      end
      local c1 = _g94
      id1 = (id1 .. c1)
      i = (i + 1)
    end
    return(id1)
  end
  local function exported()
    local m = make_id()
    local k = module_key(current_module)
    local exports = {}
    local _g97 = module(current_module).export
    local n = nil
    for n in next, _g97 do
      if (not number63(n)) then
        local b = _g97[n]
        if b.variable then
          add(exports, {"set", {"get", m, {"quote", n}}, n})
        end
      end
    end
    if some63(exports) then
      return(join({{"%local", m, {"table"}}, {"set", {"get", "nexus", {"quote", k}}, m}}, exports))
    else
      return({})
    end
  end
  local function imported(spec, ...)
    local _g98 = unstash({...})
    local all = _g98.all
    local m = make_id()
    local k = module_key(spec)
    local imports = {}
    if nexus[k] then
      local _g99 = module(spec).export
      local n = nil
      for n in next, _g99 do
        if (not number63(n)) then
          local b = _g99[n]
          if (b.variable and (all or b.export)) then
            add(imports, {"%local", n, {"get", m, {"quote", n}}})
          end
        end
      end
    end
    if some63(imports) then
      return(join({{"%local", m, {"get", "nexus", {"quote", k}}}}, imports))
    end
  end
  local function quote_binding(b)
    if is63(b.symbol) then
      return(extend(b, {_stash = true, symbol = {"quote", b.symbol}}))
    else
      if (b.macro and b.form) then
        return(exclude(extend(b, {_stash = true, macro = b.form}), {_stash = true, form = true}))
      else
        if (b.special and b.form) then
          return(exclude(extend(b, {_stash = true, special = b.form}), {_stash = true, form = true}))
        else
          if is63(b.variable) then
            return(b)
          else
            if is63(b.global) then
              return(b)
            end
          end
        end
      end
    end
  end
  local function mapo(f, t)
    local o = {}
    local _g100 = t
    local k = nil
    for k in next, _g100 do
      if (not number63(k)) then
        local v = _g100[k]
        local x = f(k, v)
        if is63(x) then
          add(o, k)
          add(o, x)
        end
      end
    end
    return(o)
  end
  local function quote_frame(t)
    return(join({"%object"}, mapo(function (_g59, b)
      return(join({"table"}, quote_binding(b)))
    end, t)))
  end
  local function quote_environment(env)
    return(join({"list"}, map(quote_frame, env)))
  end
  local function quote_module(m)
    local _g101 = {"table"}
    _g101.import = quoted(m.import)
    _g101.export = quote_frame(m.export)
    return(_g101)
  end
  local function quote_modules()
    return(join({"table"}, map(quote_module, modules)))
  end
  local function initial_environment()
    return({{["define-module"] = getenv("define-module")}})
  end
  local _g102 = {}
  nexus.utilities = _g102
  _g102.getenv = getenv
  _g102["macro-function"] = macro_function
  _g102["macro?"] = macro63
  _g102["special?"] = special63
  _g102["special-form?"] = special_form63
  _g102["statement?"] = statement63
  _g102["symbol-expansion"] = symbol_expansion
  _g102["symbol?"] = symbol63
  _g102["variable?"] = variable63
  _g102["bound?"] = bound63
  _g102["toplevel?"] = toplevel63
  _g102.quoted = quoted
  _g102["stash*"] = stash42
  _g102.bind = bind
  _g102["bind*"] = bind42
  _g102.quasiexpand = quasiexpand
  _g102.macroexpand = macroexpand
  _g102.indentation = indentation
  _g102["reserved?"] = reserved63
  _g102["valid-id?"] = valid_id63
  _g102["to-id"] = to_id
  _g102.imported = imported
  _g102.exported = exported
  _g102.mapo = mapo
  _g102["quote-environment"] = quote_environment
  _g102["quote-modules"] = quote_modules
  _g102["initial-environment"] = initial_environment
  _g102["global?"] = global63
  _g102.escape = escape
  _g102["quoting?"] = quoting63
  _g102["quasiquoting?"] = quasiquoting63
  _g102["can-unquote?"] = can_unquote63
  _g102["quasisplice?"] = quasisplice63
  _g102["quasiquote-list"] = quasiquote_list
  _g102.reserved = reserved
  _g102["numeric?"] = numeric63
  _g102["valid-char?"] = valid_char63
  _g102["quote-binding"] = quote_binding
  _g102["quote-frame"] = quote_frame
  _g102["quote-module"] = quote_module
end)();
(function ()
  local _g103 = nexus.runtime
  local nil63 = _g103["nil?"]
  local is63 = _g103["is?"]
  local length = _g103.length
  local none63 = _g103["none?"]
  local some63 = _g103["some?"]
  local hd = _g103.hd
  local string63 = _g103["string?"]
  local number63 = _g103["number?"]
  local boolean63 = _g103["boolean?"]
  local function63 = _g103["function?"]
  local composite63 = _g103["composite?"]
  local atom63 = _g103["atom?"]
  local table63 = _g103["table?"]
  local list63 = _g103["list?"]
  local substring = _g103.substring
  local sublist = _g103.sublist
  local sub = _g103.sub
  local inner = _g103.inner
  local tl = _g103.tl
  local char = _g103.char
  local code = _g103.code
  local string_literal63 = _g103["string-literal?"]
  local id_literal63 = _g103["id-literal?"]
  local add = _g103.add
  local drop = _g103.drop
  local last = _g103.last
  local reverse = _g103.reverse
  local join = _g103.join
  local reduce = _g103.reduce
  local keep = _g103.keep
  local find = _g103.find
  local pairwise = _g103.pairwise
  local iterate = _g103.iterate
  local replicate = _g103.replicate
  local splice = _g103.splice
  local map = _g103.map
  local keys63 = _g103["keys?"]
  local empty63 = _g103["empty?"]
  local stash = _g103.stash
  local unstash = _g103.unstash
  local extend = _g103.extend
  local exclude = _g103.exclude
  local search = _g103.search
  local split = _g103.split
  local cat = _g103.cat
  local _43 = _g103["+"]
  local _ = _g103["-"]
  local _42 = _g103["*"]
  local _47 = _g103["/"]
  local _37 = _g103["%"]
  local _62 = _g103[">"]
  local _60 = _g103["<"]
  local _61 = _g103["="]
  local _6261 = _g103[">="]
  local _6061 = _g103["<="]
  local read_file = _g103["read-file"]
  local write_file = _g103["write-file"]
  local write = _g103.write
  local exit = _g103.exit
  local parse_number = _g103["parse-number"]
  local to_string = _g103["to-string"]
  local apply = _g103.apply
  local make_id = _g103["make-id"]
  local _37message_handler = _g103["%message-handler"]
  local toplevel63 = _g103["toplevel?"]
  local module_key = _g103["module-key"]
  local module = _g103.module
  local setenv = _g103.setenv
  local delimiters = {["("] = true, [")"] = true, [";"] = true, ["\n"] = true}
  local whitespace = {[" "] = true, ["\t"] = true, ["\n"] = true}
  local function make_stream(str)
    return({pos = 0, string = str, len = length(str)})
  end
  local function peek_char(s)
    if (s.pos < s.len) then
      return(char(s.string, s.pos))
    end
  end
  local function read_char(s)
    local c = peek_char(s)
    if c then
      s.pos = (s.pos + 1)
      return(c)
    end
  end
  local function skip_non_code(s)
    while true do
      local c = peek_char(s)
      if nil63(c) then
        break
      else
        if whitespace[c] then
          read_char(s)
        else
          if (c == ";") then
            while (c and (not (c == "\n"))) do
              c = read_char(s)
            end
            skip_non_code(s)
          else
            break
          end
        end
      end
    end
  end
  local read_table = {}
  local eof = {}
  local function read(s)
    skip_non_code(s)
    local c = peek_char(s)
    if is63(c) then
      return(((read_table[c] or read_table[""]))(s))
    else
      return(eof)
    end
  end
  local function read_all(s)
    local l = {}
    while true do
      local form = read(s)
      if (form == eof) then
        break
      end
      add(l, form)
    end
    return(l)
  end
  local function read_from_string(str)
    return(read(make_stream(str)))
  end
  local function key63(atom)
    return((string63(atom) and (length(atom) > 1) and (char(atom, (length(atom) - 1)) == ":")))
  end
  local function flag63(atom)
    return((string63(atom) and (length(atom) > 1) and (char(atom, 0) == ":")))
  end
  read_table[""] = function (s)
    local str = ""
    local dot63 = false
    while true do
      local c = peek_char(s)
      if (c and ((not whitespace[c]) and (not delimiters[c]))) then
        if (c == ".") then
          dot63 = true
        end
        str = (str .. c)
        read_char(s)
      else
        break
      end
    end
    local n = parse_number(str)
    if is63(n) then
      return(n)
    else
      if (str == "true") then
        return(true)
      else
        if (str == "false") then
          return(false)
        else
          if (str == "_") then
            return(make_id())
          else
            if dot63 then
              return(reduce(function (a, b)
                return({"get", b, {"quote", a}})
              end, reverse(split(str, "."))))
            else
              return(str)
            end
          end
        end
      end
    end
  end
  read_table["("] = function (s)
    read_char(s)
    local l = {}
    while true do
      skip_non_code(s)
      local c = peek_char(s)
      if (c and (not (c == ")"))) then
        local x = read(s)
        if key63(x) then
          local k = sub(x, 0, (length(x) - 1))
          local v = read(s)
          l[k] = v
        else
          if flag63(x) then
            l[sub(x, 1)] = true
          else
            add(l, x)
          end
        end
      else
        if c then
          read_char(s)
          break
        else
          error(("Expected ) at " .. s.pos))
        end
      end
    end
    return(l)
  end
  read_table[")"] = function (s)
    error(("Unexpected ) at " .. s.pos))
  end
  read_table["\""] = function (s)
    read_char(s)
    local str = "\""
    while true do
      local c = peek_char(s)
      if (c and (not (c == "\""))) then
        if (c == "\\") then
          str = (str .. read_char(s))
        end
        str = (str .. read_char(s))
      else
        if c then
          read_char(s)
          break
        else
          error(("Expected \" at " .. s.pos))
        end
      end
    end
    return((str .. "\""))
  end
  read_table["|"] = function (s)
    read_char(s)
    local str = "|"
    while true do
      local c = peek_char(s)
      if (c and (not (c == "|"))) then
        str = (str .. read_char(s))
      else
        if c then
          read_char(s)
          break
        else
          error(("Expected | at " .. s.pos))
        end
      end
    end
    return((str .. "|"))
  end
  read_table["'"] = function (s)
    read_char(s)
    return({"quote", read(s)})
  end
  read_table["`"] = function (s)
    read_char(s)
    return({"quasiquote", read(s)})
  end
  read_table[","] = function (s)
    read_char(s)
    if (peek_char(s) == "@") then
      read_char(s)
      return({"unquote-splicing", read(s)})
    else
      return({"unquote", read(s)})
    end
  end
  local _g114 = {}
  nexus.reader = _g114
  _g114["make-stream"] = make_stream
  _g114["read-table"] = read_table
  _g114.read = read
  _g114["read-all"] = read_all
  _g114["read-from-string"] = read_from_string
  _g114.delimiters = delimiters
  _g114.whitespace = whitespace
  _g114["peek-char"] = peek_char
  _g114["read-char"] = read_char
  _g114["skip-non-code"] = skip_non_code
  _g114.eof = eof
  _g114["key?"] = key63
  _g114["flag?"] = flag63
end)();
(function ()
  local _g115 = nexus.runtime
  local nil63 = _g115["nil?"]
  local is63 = _g115["is?"]
  local length = _g115.length
  local none63 = _g115["none?"]
  local some63 = _g115["some?"]
  local hd = _g115.hd
  local string63 = _g115["string?"]
  local number63 = _g115["number?"]
  local boolean63 = _g115["boolean?"]
  local function63 = _g115["function?"]
  local composite63 = _g115["composite?"]
  local atom63 = _g115["atom?"]
  local table63 = _g115["table?"]
  local list63 = _g115["list?"]
  local substring = _g115.substring
  local sublist = _g115.sublist
  local sub = _g115.sub
  local inner = _g115.inner
  local tl = _g115.tl
  local char = _g115.char
  local code = _g115.code
  local string_literal63 = _g115["string-literal?"]
  local id_literal63 = _g115["id-literal?"]
  local add = _g115.add
  local drop = _g115.drop
  local last = _g115.last
  local reverse = _g115.reverse
  local join = _g115.join
  local reduce = _g115.reduce
  local keep = _g115.keep
  local find = _g115.find
  local pairwise = _g115.pairwise
  local iterate = _g115.iterate
  local replicate = _g115.replicate
  local splice = _g115.splice
  local map = _g115.map
  local keys63 = _g115["keys?"]
  local empty63 = _g115["empty?"]
  local stash = _g115.stash
  local unstash = _g115.unstash
  local extend = _g115.extend
  local exclude = _g115.exclude
  local search = _g115.search
  local split = _g115.split
  local cat = _g115.cat
  local _43 = _g115["+"]
  local _ = _g115["-"]
  local _42 = _g115["*"]
  local _47 = _g115["/"]
  local _37 = _g115["%"]
  local _62 = _g115[">"]
  local _60 = _g115["<"]
  local _61 = _g115["="]
  local _6261 = _g115[">="]
  local _6061 = _g115["<="]
  local read_file = _g115["read-file"]
  local write_file = _g115["write-file"]
  local write = _g115.write
  local exit = _g115.exit
  local parse_number = _g115["parse-number"]
  local to_string = _g115["to-string"]
  local apply = _g115.apply
  local make_id = _g115["make-id"]
  local _37message_handler = _g115["%message-handler"]
  local toplevel63 = _g115["toplevel?"]
  local module_key = _g115["module-key"]
  local module = _g115.module
  local setenv = _g115.setenv
  local _g116 = nexus.utilities
  local getenv = _g116.getenv
  local macro_function = _g116["macro-function"]
  local macro63 = _g116["macro?"]
  local special63 = _g116["special?"]
  local special_form63 = _g116["special-form?"]
  local statement63 = _g116["statement?"]
  local symbol_expansion = _g116["symbol-expansion"]
  local symbol63 = _g116["symbol?"]
  local variable63 = _g116["variable?"]
  local bound63 = _g116["bound?"]
  local toplevel63 = _g116["toplevel?"]
  local quoted = _g116.quoted
  local stash42 = _g116["stash*"]
  local bind = _g116.bind
  local bind42 = _g116["bind*"]
  local quasiexpand = _g116.quasiexpand
  local macroexpand = _g116.macroexpand
  local indentation = _g116.indentation
  local reserved63 = _g116["reserved?"]
  local valid_id63 = _g116["valid-id?"]
  local to_id = _g116["to-id"]
  local imported = _g116.imported
  local exported = _g116.exported
  local mapo = _g116.mapo
  local quote_environment = _g116["quote-environment"]
  local quote_modules = _g116["quote-modules"]
  local initial_environment = _g116["initial-environment"]
  local _g119 = nexus.reader
  local make_stream = _g119["make-stream"]
  local read_table = _g119["read-table"]
  local read = _g119.read
  local read_all = _g119["read-all"]
  local read_from_string = _g119["read-from-string"]
  local infix = {common = {["+"] = true, ["-"] = true, ["%"] = true, ["*"] = true, ["/"] = true, ["<"] = true, [">"] = true, ["<="] = true, [">="] = true}, js = {["="] = "===", ["~="] = "!=", ["and"] = "&&", ["or"] = "||", cat = "+"}, lua = {["="] = "==", cat = "..", ["~="] = true, ["and"] = true, ["or"] = true}}
  local function getop(op)
    local op1 = (infix.common[op] or infix[target][op])
    if (op1 == true) then
      return(op)
    else
      return(op1)
    end
  end
  local function infix63(form)
    return((list63(form) and is63(getop(hd(form)))))
  end
  local compile
  local function compile_args(args)
    local str = "("
    local _g120 = args
    local i = 0
    while (i < length(_g120)) do
      local arg = _g120[(i + 1)]
      str = (str .. compile(arg))
      if (i < (length(args) - 1)) then
        str = (str .. ", ")
      end
      i = (i + 1)
    end
    return((str .. ")"))
  end
  local function compile_atom(x)
    if ((x == "nil") and (target == "lua")) then
      return(x)
    else
      if (x == "nil") then
        return("undefined")
      else
        if id_literal63(x) then
          return(inner(x))
        else
          if string_literal63(x) then
            return(x)
          else
            if string63(x) then
              return(to_id(x))
            else
              if boolean63(x) then
                if x then
                  return("true")
                else
                  return("false")
                end
              else
                if number63(x) then
                  return((x .. ""))
                else
                  error("Unrecognized atom")
                end
              end
            end
          end
        end
      end
    end
  end
  local function compile_body(forms, ...)
    local _g121 = unstash({...})
    local tail = _g121.tail
    local str = ""
    local _g122 = forms
    local i = 0
    while (i < length(_g122)) do
      local x = _g122[(i + 1)]
      local t63 = (tail and (i == (length(forms) - 1)))
      str = (str .. compile(x, {_stash = true, stmt = true, tail = t63}))
      i = (i + 1)
    end
    return(str)
  end
  local function terminator(stmt63)
    if (not stmt63) then
      return("")
    else
      if (target == "js") then
        return(";\n")
      else
        return("\n")
      end
    end
  end
  local function compile_special(form, stmt63, tail63)
    local _g123 = getenv(hd(form))
    local special = _g123.special
    local stmt = _g123.stmt
    local self_tr63 = _g123.tr
    if ((not stmt63) and stmt) then
      return(compile({{"%function", {}, form}}, {_stash = true, tail = tail63}))
    else
      local tr = terminator((stmt63 and (not self_tr63)))
      return((special(tl(form), tail63) .. tr))
    end
  end
  local function compile_call(form)
    if none63(form) then
      return(compile_special({"%array"}))
    else
      local f = hd(form)
      local f1 = compile(f)
      local args = compile_args(stash42(tl(form)))
      if list63(f) then
        return(("(" .. f1 .. ")" .. args))
      else
        if string63(f) then
          return((f1 .. args))
        else
          error("Invalid function call")
        end
      end
    end
  end
  local function compile_infix(_g124)
    local op = _g124[1]
    local args = sub(_g124, 1)
    local str = "("
    local _g125 = getop(op)
    local _g126 = args
    local i = 0
    while (i < length(_g126)) do
      local arg = _g126[(i + 1)]
      if ((_g125 == "-") and (length(args) == 1)) then
        str = (str .. _g125 .. compile(arg))
      else
        str = (str .. compile(arg))
        if (i < (length(args) - 1)) then
          str = (str .. " " .. _g125 .. " ")
        end
      end
      i = (i + 1)
    end
    return((str .. ")"))
  end
  local function compile_function(args, body, ...)
    local _g127 = unstash({...})
    local name = _g127.name
    local prefix = _g127.prefix
    local _g132
    if name then
      _g132 = compile(name)
    else
      _g132 = ""
    end
    local id = _g132
    local _g128 = (prefix or "")
    local _g129 = compile_args(args)
    indent_level = (indent_level + 1)
    local _g131 = compile_body(body, {_stash = true, tail = true})
    indent_level = (indent_level - 1)
    local _g130 = _g131
    local ind = indentation()
    local _g133
    if (target == "js") then
      _g133 = ""
    else
      _g133 = "end"
    end
    local tr = _g133
    if name then
      tr = (tr .. "\n")
    end
    if (target == "js") then
      return(("function " .. id .. _g129 .. " {\n" .. _g130 .. ind .. "}" .. tr))
    else
      return((_g128 .. "function " .. id .. _g129 .. "\n" .. _g130 .. ind .. tr))
    end
  end
  local function can_return63(form)
    return(((not special_form63(form)) or (not getenv(hd(form)).stmt)))
  end
  compile = function (form, ...)
    local _g134 = unstash({...})
    local stmt = _g134.stmt
    local tail = _g134.tail
    if (tail and can_return63(form)) then
      form = {"return", form}
    end
    if nil63(form) then
      return("")
    else
      if special_form63(form) then
        return(compile_special(form, stmt, tail))
      else
        local tr = terminator(stmt)
        local _g136
        if stmt then
          _g136 = indentation()
        else
          _g136 = ""
        end
        local ind = _g136
        local _g137
        if atom63(form) then
          _g137 = compile_atom(form)
        else
          local _g138
          if infix63(form) then
            _g138 = compile_infix(form)
          else
            _g138 = compile_call(form)
          end
          _g137 = _g138
        end
        local _g135 = _g137
        return((ind .. _g135 .. tr))
      end
    end
  end
  local lower
  local function lower_statement(form)
    local hoist = {}
    local e = lower(form, hoist, true)
    if (some63(hoist) and is63(e)) then
      return(join({"do"}, join(hoist, {e})))
    else
      if is63(e) then
        return(e)
      else
        if (length(hoist) > 1) then
          return(join({"do"}, hoist))
        else
          return(hd(hoist))
        end
      end
    end
  end
  local function lower_do(args, hoist, stmt63)
    local _g139 = sub(args, 0, (length(args) - 1))
    local _g140 = 0
    while (_g140 < length(_g139)) do
      local x = _g139[(_g140 + 1)]
      add(hoist, lower(x, hoist, stmt63))
      _g140 = (_g140 + 1)
    end
    return(lower(last(args), hoist, stmt63))
  end
  local function lower_if(args, hoist, stmt63)
    local cond = args[1]
    local _g141 = args[2]
    local _g142 = args[3]
    if stmt63 then
      local _g144
      if _g142 then
        _g144 = {lower(_g142)}
      end
      return(add(hoist, join({"%if", lower(cond, hoist), lower(_g141)}, _g144)))
    else
      local e = make_id()
      add(hoist, {"%local", e})
      local _g143
      if _g142 then
        _g143 = {lower({"set", e, _g142})}
      end
      add(hoist, join({"%if", lower(cond, hoist), lower({"set", e, _g141})}, _g143))
      return(e)
    end
  end
  local function lower_while(args, hoist)
    local c = args[1]
    local body = sub(args, 1)
    return(add(hoist, {"while", lower(c, hoist), lower(join({"do"}, body))}))
  end
  local function lower_for(args, hoist)
    local t = args[1]
    local k = args[2]
    local body = sub(args, 2)
    return(add(hoist, {"%for", lower(t, hoist), k, lower(join({"do"}, body))}))
  end
  local function lower_function(args)
    local a = args[1]
    local body = sub(args, 1)
    return({"%function", a, lower(join({"do"}, body))})
  end
  local function lower_definition(kind, args, hoist)
    local name = args[1]
    local _g145 = args[2]
    local body = sub(args, 2)
    return(add(hoist, {kind, name, _g145, lower(join({"do"}, body))}))
  end
  local function lower_call(form, hoist)
    local _g146 = map(function (x)
      return(lower(x, hoist))
    end, form)
    if some63(_g146) then
      return(_g146)
    end
  end
  local function lower_special(form, hoist)
    local e = lower_call(form, hoist)
    if e then
      return(add(hoist, e))
    end
  end
  lower = function (form, hoist, stmt63)
    if atom63(form) then
      return(form)
    else
      if empty63(form) then
        return({"%array"})
      else
        if nil63(hoist) then
          return(lower_statement(form))
        else
          local x = form[1]
          local args = sub(form, 1)
          if (x == "do") then
            return(lower_do(args, hoist, stmt63))
          else
            if (x == "%if") then
              return(lower_if(args, hoist, stmt63))
            else
              if (x == "while") then
                return(lower_while(args, hoist))
              else
                if (x == "%for") then
                  return(lower_for(args, hoist))
                else
                  if (x == "%try") then
                    return({"%try", lower(join({"do"}, args))})
                  else
                    if (x == "%function") then
                      return(lower_function(args))
                    else
                      if ((x == "%local-function") or (x == "%global-function")) then
                        return(lower_definition(x, args, hoist))
                      else
                        if statement63(x) then
                          return(lower_special(form, hoist))
                        else
                          return(lower_call(form, hoist))
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  lower = lower
  local function process(form)
    return(lower(macroexpand(form)))
  end
  current_module = nil
  local function module_path(spec)
    return((module_key(spec) .. ".l"))
  end
  local function encapsulate(body)
    local _g147 = map(process, body)
    local epilog = map(process, exported())
    return({join({"%function", {}}, join(_g147, epilog))})
  end
  local function compile_file(file)
    local str = read_file(file)
    local body = read_all(make_stream(str))
    local form = encapsulate(body)
    return((compile(form) .. ";\n"))
  end
  _37result = nil
  local function run(x)
    local f = load((compile("%result") .. "=" .. x))
    if f then
      f()
      return(_37result)
    else
      local f,e = load(x)
      if f then
        return(f())
      else
        error((e .. " in " .. x))
      end
    end
  end
  local compiling63 = false
  local compiler_output = ""
  local function _37compile_module(spec)
    local path = module_path(spec)
    local mod0 = current_module
    local env0 = environment
    current_module = spec
    environment = initial_environment()
    local compiled = compile_file(path)
    current_module = mod0
    environment = env0
    if compiling63 then
      compiler_output = (compiler_output .. compiled)
    else
      return(run(compiled))
    end
  end
  local function open_module(spec, ...)
    local _g148 = unstash({...})
    local all = _g148.all
    local m = module(spec)
    local frame = last(environment)
    local _g149 = m.export
    local k = nil
    for k in next, _g149 do
      if (not number63(k)) then
        local v = _g149[k]
        if (v.export or all) then
          frame[k] = v
        end
      end
    end
  end
  local function load_module(spec, ...)
    local _g150 = unstash({...})
    local all = _g150.all
    if nil63(module(spec)) then
      _37compile_module(spec)
    end
    return(open_module(spec, {_stash = true, all = all}))
  end
  local function in_module(spec)
    load_module(spec, {_stash = true, all = true})
    local m = module(spec)
    map(open_module, m.import)
    current_module = spec
  end
  local function compile_module(spec)
    compiling63 = true
    _37compile_module(spec)
    return(compiler_output)
  end
  local function prologue()
    local m = module(current_module)
    return(join(imported(current_module, {_stash = true, all = true}), map(function (x)
      return(splice(imported(x)))
    end, m.import)))
  end
  local function eval(form)
    local previous = target
    target = "lua"
    local _g151 = process(join({"do"}, join(prologue(), {form})))
    local compiled = compile(_g151)
    target = previous
    return(run(compiled))
  end
  local _g152 = {}
  nexus.compiler = _g152
  _g152["compile-body"] = compile_body
  _g152["compile-call"] = compile_call
  _g152["compile-function"] = compile_function
  _g152["compile-special"] = compile_special
  _g152.compile = compile
  _g152["open-module"] = open_module
  _g152["load-module"] = load_module
  _g152["in-module"] = in_module
  _g152["compile-module"] = compile_module
  _g152.eval = eval
  _g152.infix = infix
  _g152.getop = getop
  _g152["infix?"] = infix63
  _g152["compile-args"] = compile_args
  _g152["compile-atom"] = compile_atom
  _g152.terminator = terminator
  _g152["compile-infix"] = compile_infix
  _g152["can-return?"] = can_return63
  _g152.lower = lower
  _g152["lower-statement"] = lower_statement
  _g152["lower-do"] = lower_do
  _g152["lower-if"] = lower_if
  _g152["lower-while"] = lower_while
  _g152["lower-for"] = lower_for
  _g152["lower-function"] = lower_function
  _g152["lower-definition"] = lower_definition
  _g152["lower-call"] = lower_call
  _g152["lower-special"] = lower_special
  _g152.process = process
  _g152["module-path"] = module_path
  _g152.encapsulate = encapsulate
  _g152["compile-file"] = compile_file
  _g152.run = run
  _g152["compiling?"] = compiling63
  _g152["compiler-output"] = compiler_output
  _g152["%compile-module"] = _37compile_module
  _g152.prologue = prologue
end)();
(function ()
  local _g154 = nexus.runtime
  local nil63 = _g154["nil?"]
  local is63 = _g154["is?"]
  local length = _g154.length
  local none63 = _g154["none?"]
  local some63 = _g154["some?"]
  local hd = _g154.hd
  local string63 = _g154["string?"]
  local number63 = _g154["number?"]
  local boolean63 = _g154["boolean?"]
  local function63 = _g154["function?"]
  local composite63 = _g154["composite?"]
  local atom63 = _g154["atom?"]
  local table63 = _g154["table?"]
  local list63 = _g154["list?"]
  local substring = _g154.substring
  local sublist = _g154.sublist
  local sub = _g154.sub
  local inner = _g154.inner
  local tl = _g154.tl
  local char = _g154.char
  local code = _g154.code
  local string_literal63 = _g154["string-literal?"]
  local id_literal63 = _g154["id-literal?"]
  local add = _g154.add
  local drop = _g154.drop
  local last = _g154.last
  local reverse = _g154.reverse
  local join = _g154.join
  local reduce = _g154.reduce
  local keep = _g154.keep
  local find = _g154.find
  local pairwise = _g154.pairwise
  local iterate = _g154.iterate
  local replicate = _g154.replicate
  local splice = _g154.splice
  local map = _g154.map
  local keys63 = _g154["keys?"]
  local empty63 = _g154["empty?"]
  local stash = _g154.stash
  local unstash = _g154.unstash
  local extend = _g154.extend
  local exclude = _g154.exclude
  local search = _g154.search
  local split = _g154.split
  local cat = _g154.cat
  local _43 = _g154["+"]
  local _ = _g154["-"]
  local _42 = _g154["*"]
  local _47 = _g154["/"]
  local _37 = _g154["%"]
  local _62 = _g154[">"]
  local _60 = _g154["<"]
  local _61 = _g154["="]
  local _6261 = _g154[">="]
  local _6061 = _g154["<="]
  local read_file = _g154["read-file"]
  local write_file = _g154["write-file"]
  local write = _g154.write
  local exit = _g154.exit
  local parse_number = _g154["parse-number"]
  local to_string = _g154["to-string"]
  local apply = _g154.apply
  local make_id = _g154["make-id"]
  local _37message_handler = _g154["%message-handler"]
  local toplevel63 = _g154["toplevel?"]
  local module_key = _g154["module-key"]
  local module = _g154.module
  local setenv = _g154.setenv
  local _g155 = nexus.utilities
  local getenv = _g155.getenv
  local macro_function = _g155["macro-function"]
  local macro63 = _g155["macro?"]
  local special63 = _g155["special?"]
  local special_form63 = _g155["special-form?"]
  local statement63 = _g155["statement?"]
  local symbol_expansion = _g155["symbol-expansion"]
  local symbol63 = _g155["symbol?"]
  local variable63 = _g155["variable?"]
  local bound63 = _g155["bound?"]
  local toplevel63 = _g155["toplevel?"]
  local quoted = _g155.quoted
  local stash42 = _g155["stash*"]
  local bind = _g155.bind
  local bind42 = _g155["bind*"]
  local quasiexpand = _g155.quasiexpand
  local macroexpand = _g155.macroexpand
  local indentation = _g155.indentation
  local reserved63 = _g155["reserved?"]
  local valid_id63 = _g155["valid-id?"]
  local to_id = _g155["to-id"]
  local imported = _g155.imported
  local exported = _g155.exported
  local mapo = _g155.mapo
  local quote_environment = _g155["quote-environment"]
  local quote_modules = _g155["quote-modules"]
  local initial_environment = _g155["initial-environment"]
  local _g158 = nexus.compiler
  local compile_body = _g158["compile-body"]
  local compile_call = _g158["compile-call"]
  local compile_function = _g158["compile-function"]
  local compile_special = _g158["compile-special"]
  local compile = _g158.compile
  local open_module = _g158["open-module"]
  local load_module = _g158["load-module"]
  local in_module = _g158["in-module"]
  local compile_module = _g158["compile-module"]
  local eval = _g158.eval
  local lower = _g158.lower
end)();
(function ()
  local _g368 = nexus.runtime
  local nil63 = _g368["nil?"]
  local is63 = _g368["is?"]
  local length = _g368.length
  local none63 = _g368["none?"]
  local some63 = _g368["some?"]
  local hd = _g368.hd
  local string63 = _g368["string?"]
  local number63 = _g368["number?"]
  local boolean63 = _g368["boolean?"]
  local function63 = _g368["function?"]
  local composite63 = _g368["composite?"]
  local atom63 = _g368["atom?"]
  local table63 = _g368["table?"]
  local list63 = _g368["list?"]
  local substring = _g368.substring
  local sublist = _g368.sublist
  local sub = _g368.sub
  local inner = _g368.inner
  local tl = _g368.tl
  local char = _g368.char
  local code = _g368.code
  local string_literal63 = _g368["string-literal?"]
  local id_literal63 = _g368["id-literal?"]
  local add = _g368.add
  local drop = _g368.drop
  local last = _g368.last
  local reverse = _g368.reverse
  local join = _g368.join
  local reduce = _g368.reduce
  local keep = _g368.keep
  local find = _g368.find
  local pairwise = _g368.pairwise
  local iterate = _g368.iterate
  local replicate = _g368.replicate
  local splice = _g368.splice
  local map = _g368.map
  local keys63 = _g368["keys?"]
  local empty63 = _g368["empty?"]
  local stash = _g368.stash
  local unstash = _g368.unstash
  local extend = _g368.extend
  local exclude = _g368.exclude
  local search = _g368.search
  local split = _g368.split
  local cat = _g368.cat
  local _43 = _g368["+"]
  local _ = _g368["-"]
  local _42 = _g368["*"]
  local _47 = _g368["/"]
  local _37 = _g368["%"]
  local _62 = _g368[">"]
  local _60 = _g368["<"]
  local _61 = _g368["="]
  local _6261 = _g368[">="]
  local _6061 = _g368["<="]
  local read_file = _g368["read-file"]
  local write_file = _g368["write-file"]
  local write = _g368.write
  local exit = _g368.exit
  local parse_number = _g368["parse-number"]
  local to_string = _g368["to-string"]
  local apply = _g368.apply
  local make_id = _g368["make-id"]
  local _37message_handler = _g368["%message-handler"]
  local toplevel63 = _g368["toplevel?"]
  local module_key = _g368["module-key"]
  local module = _g368.module
  local setenv = _g368.setenv
  local _g369 = nexus.utilities
  local getenv = _g369.getenv
  local macro_function = _g369["macro-function"]
  local macro63 = _g369["macro?"]
  local special63 = _g369["special?"]
  local special_form63 = _g369["special-form?"]
  local statement63 = _g369["statement?"]
  local symbol_expansion = _g369["symbol-expansion"]
  local symbol63 = _g369["symbol?"]
  local variable63 = _g369["variable?"]
  local bound63 = _g369["bound?"]
  local toplevel63 = _g369["toplevel?"]
  local quoted = _g369.quoted
  local stash42 = _g369["stash*"]
  local bind = _g369.bind
  local bind42 = _g369["bind*"]
  local quasiexpand = _g369.quasiexpand
  local macroexpand = _g369.macroexpand
  local indentation = _g369.indentation
  local reserved63 = _g369["reserved?"]
  local valid_id63 = _g369["valid-id?"]
  local to_id = _g369["to-id"]
  local imported = _g369.imported
  local exported = _g369.exported
  local mapo = _g369.mapo
  local quote_environment = _g369["quote-environment"]
  local quote_modules = _g369["quote-modules"]
  local initial_environment = _g369["initial-environment"]
  local _g372 = nexus.compiler
  local compile_body = _g372["compile-body"]
  local compile_call = _g372["compile-call"]
  local compile_function = _g372["compile-function"]
  local compile_special = _g372["compile-special"]
  local compile = _g372.compile
  local open_module = _g372["open-module"]
  local load_module = _g372["load-module"]
  local in_module = _g372["in-module"]
  local compile_module = _g372["compile-module"]
  local eval = _g372.eval
  local lower = _g372.lower
  target = "lua"
end)();
(function ()
  local _g650 = nexus.runtime
  local nil63 = _g650["nil?"]
  local is63 = _g650["is?"]
  local length = _g650.length
  local none63 = _g650["none?"]
  local some63 = _g650["some?"]
  local hd = _g650.hd
  local string63 = _g650["string?"]
  local number63 = _g650["number?"]
  local boolean63 = _g650["boolean?"]
  local function63 = _g650["function?"]
  local composite63 = _g650["composite?"]
  local atom63 = _g650["atom?"]
  local table63 = _g650["table?"]
  local list63 = _g650["list?"]
  local substring = _g650.substring
  local sublist = _g650.sublist
  local sub = _g650.sub
  local inner = _g650.inner
  local tl = _g650.tl
  local char = _g650.char
  local code = _g650.code
  local string_literal63 = _g650["string-literal?"]
  local id_literal63 = _g650["id-literal?"]
  local add = _g650.add
  local drop = _g650.drop
  local last = _g650.last
  local reverse = _g650.reverse
  local join = _g650.join
  local reduce = _g650.reduce
  local keep = _g650.keep
  local find = _g650.find
  local pairwise = _g650.pairwise
  local iterate = _g650.iterate
  local replicate = _g650.replicate
  local splice = _g650.splice
  local map = _g650.map
  local keys63 = _g650["keys?"]
  local empty63 = _g650["empty?"]
  local stash = _g650.stash
  local unstash = _g650.unstash
  local extend = _g650.extend
  local exclude = _g650.exclude
  local search = _g650.search
  local split = _g650.split
  local cat = _g650.cat
  local _43 = _g650["+"]
  local _ = _g650["-"]
  local _42 = _g650["*"]
  local _47 = _g650["/"]
  local _37 = _g650["%"]
  local _62 = _g650[">"]
  local _60 = _g650["<"]
  local _61 = _g650["="]
  local _6261 = _g650[">="]
  local _6061 = _g650["<="]
  local read_file = _g650["read-file"]
  local write_file = _g650["write-file"]
  local write = _g650.write
  local exit = _g650.exit
  local parse_number = _g650["parse-number"]
  local to_string = _g650["to-string"]
  local apply = _g650.apply
  local make_id = _g650["make-id"]
  local _37message_handler = _g650["%message-handler"]
  local toplevel63 = _g650["toplevel?"]
  local module_key = _g650["module-key"]
  local module = _g650.module
  local setenv = _g650.setenv
  local _g651 = nexus.utilities
  local getenv = _g651.getenv
  local macro_function = _g651["macro-function"]
  local macro63 = _g651["macro?"]
  local special63 = _g651["special?"]
  local special_form63 = _g651["special-form?"]
  local statement63 = _g651["statement?"]
  local symbol_expansion = _g651["symbol-expansion"]
  local symbol63 = _g651["symbol?"]
  local variable63 = _g651["variable?"]
  local bound63 = _g651["bound?"]
  local toplevel63 = _g651["toplevel?"]
  local quoted = _g651.quoted
  local stash42 = _g651["stash*"]
  local bind = _g651.bind
  local bind42 = _g651["bind*"]
  local quasiexpand = _g651.quasiexpand
  local macroexpand = _g651.macroexpand
  local indentation = _g651.indentation
  local reserved63 = _g651["reserved?"]
  local valid_id63 = _g651["valid-id?"]
  local to_id = _g651["to-id"]
  local imported = _g651.imported
  local exported = _g651.exported
  local mapo = _g651.mapo
  local quote_environment = _g651["quote-environment"]
  local quote_modules = _g651["quote-modules"]
  local initial_environment = _g651["initial-environment"]
  local _g654 = nexus.compiler
  local compile_body = _g654["compile-body"]
  local compile_call = _g654["compile-call"]
  local compile_function = _g654["compile-function"]
  local compile_special = _g654["compile-special"]
  local compile = _g654.compile
  local open_module = _g654["open-module"]
  local load_module = _g654["load-module"]
  local in_module = _g654["in-module"]
  local compile_module = _g654["compile-module"]
  local eval = _g654.eval
  local lower = _g654.lower
  modules = {optimizer = {import = {"runtime", "special", "core"}, export = {optimizations = {variable = true}, optimize = {variable = true, export = true}, ["define-optimization"] = {}}}, main = {import = {"runtime", "special", "core", "reader", "compiler"}, export = {save = {macro = function (...)
    local specs = unstash({...})
    local _g667 = sub(specs, 0)
    map(compile_module, _g667)
    return(nil)
  end}}}, lib = {import = {"core", "special"}, export = {}}, runtime = {import = {"special", "core"}, export = {["nil?"] = {export = true, variable = true}, ["is?"] = {export = true, variable = true}, length = {export = true, variable = true}, ["none?"] = {export = true, variable = true}, ["some?"] = {export = true, variable = true}, hd = {export = true, variable = true}, ["string?"] = {export = true, variable = true}, ["number?"] = {export = true, variable = true}, ["boolean?"] = {export = true, variable = true}, ["function?"] = {export = true, variable = true}, ["composite?"] = {export = true, variable = true}, ["atom?"] = {export = true, variable = true}, ["table?"] = {export = true, variable = true}, ["list?"] = {export = true, variable = true}, substring = {export = true, variable = true}, sublist = {export = true, variable = true}, sub = {export = true, variable = true}, inner = {export = true, variable = true}, tl = {export = true, variable = true}, char = {export = true, variable = true}, code = {export = true, variable = true}, ["string-literal?"] = {export = true, variable = true}, ["id-literal?"] = {export = true, variable = true}, add = {export = true, variable = true}, drop = {export = true, variable = true}, last = {export = true, variable = true}, reverse = {export = true, variable = true}, join = {export = true, variable = true}, reduce = {export = true, variable = true}, keep = {export = true, variable = true}, find = {export = true, variable = true}, pairwise = {export = true, variable = true}, iterate = {export = true, variable = true}, replicate = {export = true, variable = true}, splice = {export = true, variable = true}, map = {export = true, variable = true}, ["keys?"] = {export = true, variable = true}, ["empty?"] = {export = true, variable = true}, stash = {export = true, variable = true}, unstash = {export = true, variable = true}, extend = {export = true, variable = true}, exclude = {export = true, variable = true}, search = {export = true, variable = true}, split = {export = true, variable = true}, cat = {export = true, variable = true}, ["+"] = {export = true, variable = true}, ["-"] = {export = true, variable = true}, ["*"] = {export = true, variable = true}, ["/"] = {export = true, variable = true}, ["%"] = {export = true, variable = true}, [">"] = {export = true, variable = true}, ["<"] = {export = true, variable = true}, ["="] = {export = true, variable = true}, [">="] = {export = true, variable = true}, ["<="] = {export = true, variable = true}, ["read-file"] = {export = true, variable = true}, ["write-file"] = {export = true, variable = true}, write = {export = true, variable = true}, exit = {export = true, variable = true}, ["parse-number"] = {export = true, variable = true}, ["to-string"] = {export = true, variable = true}, apply = {export = true, variable = true}, ["make-id"] = {export = true, variable = true}, ["%message-handler"] = {export = true, variable = true}, ["toplevel?"] = {export = true, variable = true}, ["module-key"] = {export = true, variable = true}, module = {export = true, variable = true}, setenv = {export = true, variable = true}, ["splice?"] = {variable = true}, mapl = {variable = true}, ["id-count"] = {variable = true}}}, special = {import = {"runtime", "utilities", "special", "core", "compiler"}, export = {["do"] = {stmt = true, special = function (forms, tail63)
    return(compile_body(forms, {_stash = true, tail = tail63}))
  end, tr = true, export = true}, ["%if"] = {stmt = true, special = function (_g668, tail63)
    local cond = _g668[1]
    local _g669 = _g668[2]
    local _g670 = _g668[3]
    local _g671 = compile(cond)
    indent_level = (indent_level + 1)
    local _g674 = compile(_g669, {_stash = true, stmt = true, tail = tail63})
    indent_level = (indent_level - 1)
    local _g672 = _g674
    local _g751
    if _g670 then
      indent_level = (indent_level + 1)
      local _g675 = compile(_g670, {_stash = true, stmt = true, tail = tail63})
      indent_level = (indent_level - 1)
      _g751 = _g675
    end
    local _g673 = _g751
    local ind = indentation()
    local str = ""
    if (target == "js") then
      str = (str .. ind .. "if (" .. _g671 .. ") {\n" .. _g672 .. ind .. "}")
    else
      str = (str .. ind .. "if " .. _g671 .. " then\n" .. _g672)
    end
    if (_g673 and (target == "js")) then
      str = (str .. " else {\n" .. _g673 .. ind .. "}")
    else
      if _g673 then
        str = (str .. ind .. "else\n" .. _g673)
      end
    end
    if (target == "lua") then
      return((str .. ind .. "end\n"))
    else
      return((str .. "\n"))
    end
  end, tr = true, export = true}, ["while"] = {stmt = true, special = function (_g676)
    local condition = _g676[1]
    local body = sub(_g676, 1)
    local _g677 = compile(condition)
    indent_level = (indent_level + 1)
    local _g679 = compile_body(body)
    indent_level = (indent_level - 1)
    local _g678 = _g679
    local ind = indentation()
    if (target == "js") then
      return((ind .. "while (" .. _g677 .. ") {\n" .. _g678 .. ind .. "}\n"))
    else
      return((ind .. "while " .. _g677 .. " do\n" .. _g678 .. ind .. "end\n"))
    end
  end, tr = true, export = true}, ["%for"] = {stmt = true, special = function (_g680)
    local t = _g680[1]
    local k = _g680[2]
    local body = sub(_g680, 2)
    local _g681 = compile(t)
    local ind = indentation()
    indent_level = (indent_level + 1)
    local _g683 = compile_body(body)
    indent_level = (indent_level - 1)
    local _g682 = _g683
    if (target == "lua") then
      return((ind .. "for " .. k .. " in next, " .. _g681 .. " do\n" .. _g682 .. ind .. "end\n"))
    else
      return((ind .. "for (" .. k .. " in " .. _g681 .. ") {\n" .. _g682 .. ind .. "}\n"))
    end
  end, tr = true, export = true}, ["%try"] = {stmt = true, special = function (forms)
    local ind = indentation()
    indent_level = (indent_level + 1)
    local _g684 = compile_body(forms, {_stash = true, tail = true})
    indent_level = (indent_level - 1)
    local body = _g684
    local e = make_id()
    local handler = {"return", {"%array", false, {"get", e, "\"message\""}}}
    indent_level = (indent_level + 1)
    local _g685 = compile(handler, {_stash = true, stmt = true})
    indent_level = (indent_level - 1)
    local h = _g685
    return((ind .. "try {\n" .. body .. ind .. "}\n" .. ind .. "catch (" .. e .. ") {\n" .. h .. ind .. "}\n"))
  end, tr = true, export = true}, ["break"] = {special = function (_g153)
    return((indentation() .. "break"))
  end, stmt = true, export = true}, ["%function"] = {export = true, special = function (_g686)
    local args = _g686[1]
    local body = sub(_g686, 1)
    return(compile_function(args, body))
  end}, ["%global-function"] = {stmt = true, special = function (_g687)
    local name = _g687[1]
    local args = _g687[2]
    local body = sub(_g687, 2)
    if (target == "lua") then
      local x = compile_function(args, body, {_stash = true, name = name})
      return((indentation() .. x))
    else
      return(compile({"set", name, join({"%function", args}, body)}, {_stash = true, stmt = true}))
    end
  end, tr = true, export = true}, ["%local-function"] = {stmt = true, special = function (_g688)
    local name = _g688[1]
    local args = _g688[2]
    local body = sub(_g688, 2)
    local x = compile_function(args, body, {_stash = true, name = name, prefix = "local "})
    return((indentation() .. x))
  end, tr = true, export = true}, ["return"] = {special = function (_g689)
    local x = _g689[1]
    local _g752
    if nil63(x) then
      _g752 = "return"
    else
      _g752 = compile_call({"return", x})
    end
    local _g690 = _g752
    return((indentation() .. _g690))
  end, stmt = true, export = true}, ["error"] = {special = function (_g691)
    local x = _g691[1]
    local _g753
    if (target == "js") then
      _g753 = ("throw new " .. compile({"Error", x}))
    else
      _g753 = compile_call({"error", x})
    end
    local e = _g753
    return((indentation() .. e))
  end, stmt = true, export = true}, ["%local"] = {special = function (_g692)
    local name = _g692[1]
    local value = _g692[2]
    local id = compile(name)
    local value1 = compile(value)
    local _g754
    if is63(value) then
      _g754 = (" = " .. value1)
    else
      _g754 = ""
    end
    local rh = _g754
    local _g755
    if (target == "js") then
      _g755 = "var "
    else
      _g755 = "local "
    end
    local keyword = _g755
    local ind = indentation()
    return((ind .. keyword .. id .. rh))
  end, stmt = true, export = true}, ["set"] = {special = function (_g693)
    local lh = _g693[1]
    local rh = _g693[2]
    local _g694 = compile(lh)
    local _g756
    if nil63(rh) then
      _g756 = "nil"
    else
      _g756 = rh
    end
    local _g695 = compile(_g756)
    return((indentation() .. _g694 .. " = " .. _g695))
  end, stmt = true, export = true}, ["get"] = {export = true, special = function (_g696)
    local t = _g696[1]
    local k = _g696[2]
    local _g697 = compile(t)
    local k1 = compile(k)
    if ((target == "lua") and (char(_g697, 0) == "{")) then
      _g697 = ("(" .. _g697 .. ")")
    end
    if (string_literal63(k) and valid_id63(inner(k))) then
      return((_g697 .. "." .. inner(k)))
    else
      return((_g697 .. "[" .. k1 .. "]"))
    end
  end}, ["not"] = {export = true, special = function (_g698)
    local x = _g698[1]
    local _g699 = compile(x)
    local _g757
    if (target == "js") then
      _g757 = "!("
    else
      _g757 = "(not "
    end
    local open = _g757
    return((open .. _g699 .. ")"))
  end}, ["%array"] = {export = true, special = function (forms)
    local _g758
    if (target == "lua") then
      _g758 = "{"
    else
      _g758 = "["
    end
    local open = _g758
    local _g759
    if (target == "lua") then
      _g759 = "}"
    else
      _g759 = "]"
    end
    local close = _g759
    local str = ""
    local _g700 = forms
    local i = 0
    while (i < length(_g700)) do
      local x = _g700[(i + 1)]
      str = (str .. compile(x))
      if (i < (length(forms) - 1)) then
        str = (str .. ", ")
      end
      i = (i + 1)
    end
    return((open .. str .. close))
  end}, ["%object"] = {export = true, special = function (forms)
    local str = "{"
    local _g760
    if (target == "lua") then
      _g760 = " = "
    else
      _g760 = ": "
    end
    local sep = _g760
    local pairs = pairwise(forms)
    local _g701 = pairs
    local i = 0
    while (i < length(_g701)) do
      local _g702 = _g701[(i + 1)]
      local k = _g702[1]
      local v = _g702[2]
      if (not string63(k)) then
        error(("Illegal key: " .. to_string(k)))
      end
      local _g703 = compile(v)
      local _g761
      if valid_id63(k) then
        _g761 = k
      else
        local _g762
        if ((target == "js") and string_literal63(k)) then
          _g762 = k
        else
          local _g763
          if (target == "js") then
            _g763 = quoted(k)
          else
            local _g764
            if string_literal63(k) then
              _g764 = ("[" .. k .. "]")
            else
              _g764 = ("[" .. quoted(k) .. "]")
            end
            _g763 = _g764
          end
          _g762 = _g763
        end
        _g761 = _g762
      end
      local _g704 = _g761
      str = (str .. _g704 .. sep .. _g703)
      if (i < (length(pairs) - 1)) then
        str = (str .. ", ")
      end
      i = (i + 1)
    end
    return((str .. "}"))
  end}}}, boot = {import = {"runtime", "utilities", "special", "core", "compiler"}, export = {["%initial-environment"] = {macro = function ()
    return(quote_environment(initial_environment()))
  end}, ["%initial-modules"] = {macro = function ()
    return(quote_modules())
  end}, modules = {global = true, export = true}}}, reader = {import = {"runtime", "special", "core"}, export = {["make-stream"] = {export = true, variable = true}, ["read-table"] = {export = true, variable = true}, ["define-reader"] = {export = true, macro = function (_g705, ...)
    local char = _g705[1]
    local stream = _g705[2]
    local body = unstash({...})
    local _g706 = sub(body, 0)
    return({"set", {"get", "read-table", char}, join({"fn", {stream}}, _g706)})
  end}, read = {export = true, variable = true}, ["read-all"] = {export = true, variable = true}, ["read-from-string"] = {export = true, variable = true}, delimiters = {variable = true}, whitespace = {variable = true}, ["peek-char"] = {variable = true}, ["read-char"] = {variable = true}, ["skip-non-code"] = {variable = true}, eof = {variable = true}, ["key?"] = {variable = true}, ["flag?"] = {variable = true}}}, utilities = {import = {"runtime", "special", "core"}, export = {getenv = {export = true, variable = true}, ["macro-function"] = {export = true, variable = true}, ["macro?"] = {export = true, variable = true}, ["special?"] = {export = true, variable = true}, ["special-form?"] = {export = true, variable = true}, ["statement?"] = {export = true, variable = true}, ["symbol-expansion"] = {export = true, variable = true}, ["symbol?"] = {export = true, variable = true}, ["variable?"] = {export = true, variable = true}, ["bound?"] = {export = true, variable = true}, ["toplevel?"] = {export = true, variable = true}, quoted = {export = true, variable = true}, ["stash*"] = {export = true, variable = true}, bind = {export = true, variable = true}, ["bind*"] = {export = true, variable = true}, quasiexpand = {export = true, variable = true}, macroexpand = {export = true, variable = true}, indentation = {export = true, variable = true}, ["with-indent"] = {export = true, macro = function (form)
    local result = make_id()
    return({"do", {"inc", "indent-level"}, {"let", {result, form}, {"dec", "indent-level"}, result}})
  end}, ["reserved?"] = {export = true, variable = true}, ["valid-id?"] = {export = true, variable = true}, ["to-id"] = {export = true, variable = true}, imported = {export = true, variable = true}, exported = {export = true, variable = true}, mapo = {export = true, variable = true}, ["quote-environment"] = {export = true, variable = true}, ["quote-modules"] = {export = true, variable = true}, ["initial-environment"] = {export = true, variable = true}, ["global?"] = {variable = true}, escape = {variable = true}, ["quoting?"] = {variable = true}, ["quasiquoting?"] = {variable = true}, ["can-unquote?"] = {variable = true}, ["quasisplice?"] = {variable = true}, ["quasiquote-list"] = {variable = true}, ["indent-level"] = {global = true, export = true}, reserved = {variable = true}, ["numeric?"] = {variable = true}, ["valid-char?"] = {variable = true}, ["quote-binding"] = {variable = true}, ["quote-frame"] = {variable = true}, ["quote-module"] = {variable = true}}}, core = {import = {"runtime", "utilities", "special", "core", "compiler"}, export = {quote = {export = true, macro = function (form)
    return(quoted(form))
  end}, quasiquote = {export = true, macro = function (form)
    return(quasiexpand(form, 1))
  end}, at = {export = true, macro = function (l, i)
    if ((target == "lua") and number63(i)) then
      i = (i + 1)
    else
      if (target == "lua") then
        i = {"+", i, 1}
      end
    end
    return({"get", l, i})
  end}, list = {export = true, macro = function (...)
    local body = unstash({...})
    local l = join({"%array"}, body)
    if (not keys63(body)) then
      return(l)
    else
      local id = make_id()
      local init = {}
      local _g707 = body
      local k = nil
      for k in next, _g707 do
        if (not number63(k)) then
          local v = _g707[k]
          add(init, {"set", {"get", id, {"quote", k}}, v})
        end
      end
      return(join({"let", {id, l}}, join(init, {id})))
    end
  end}, ["if"] = {export = true, macro = function (...)
    local branches = unstash({...})
    local function step(_g708)
      local a = _g708[1]
      local b = _g708[2]
      local c = sub(_g708, 2)
      if is63(b) then
        return({join({"%if", a, b}, step(c))})
      else
        if is63(a) then
          return({a})
        end
      end
    end
    return(hd(step(branches)))
  end}, table = {export = true, macro = function (...)
    local body = unstash({...})
    return(join({"%object"}, mapo(function (_g367, x)
      return(x)
    end, body)))
  end}, let = {export = true, macro = function (bindings, ...)
    local body = unstash({...})
    local _g709 = sub(body, 0)
    local i = 0
    local renames = {}
    local locals = {}
    map(function (_g710)
      local lh = _g710[1]
      local rh = _g710[2]
      local _g711 = bind(lh, rh)
      local _g712 = 0
      while (_g712 < length(_g711)) do
        local _g713 = _g711[(_g712 + 1)]
        local id = _g713[1]
        local val = _g713[2]
        if (bound63(id) or reserved63(id) or toplevel63()) then
          local rename = make_id()
          add(renames, id)
          add(renames, rename)
          id = rename
        else
          setenv(id, {_stash = true, variable = true})
        end
        add(locals, {"%local", id, val})
        _g712 = (_g712 + 1)
      end
    end, pairwise(bindings))
    return(join({"do"}, join(locals, {join({"let-symbol", renames}, _g709)})))
  end}, ["define-module"] = {export = true, macro = function (spec, ...)
    local body = unstash({...})
    local _g714 = sub(body, 0)
    local imports = {}
    local imp = _g714.import
    local exp = _g714.export
    local _g715 = (imp or {})
    local _g716 = 0
    while (_g716 < length(_g715)) do
      local k = _g715[(_g716 + 1)]
      load_module(k)
      imports = join(imports, imported(k))
      _g716 = (_g716 + 1)
    end
    modules[module_key(spec)] = {import = imp, export = {}}
    local _g717 = (exp or {})
    local _g718 = 0
    while (_g718 < length(_g717)) do
      local k = _g717[(_g718 + 1)]
      setenv(k, {_stash = true, export = true})
      _g718 = (_g718 + 1)
    end
    return(join({"do"}, imports))
  end}, ["define-macro"] = {export = true, macro = function (name, args, ...)
    local body = unstash({...})
    local _g719 = sub(body, 0)
    local form = join({"fn", args}, _g719)
    local _g720 = {"setenv", {"quote", name}}
    _g720.macro = form
    _g720.form = {"quote", form}
    eval(_g720)
    return(nil)
  end}, ["define-special"] = {export = true, macro = function (name, args, ...)
    local body = unstash({...})
    local _g721 = sub(body, 0)
    local form = join({"fn", args}, _g721)
    local keys = sub(_g721, length(_g721))
    local _g722 = {"setenv", {"quote", name}}
    _g722.special = form
    _g722.form = {"quote", form}
    eval(join(_g722, keys))
    return(nil)
  end}, ["define-symbol"] = {export = true, macro = function (name, expansion)
    setenv(name, {_stash = true, symbol = expansion})
    return(nil)
  end}, define = {export = true, macro = function (name, x, ...)
    local body = unstash({...})
    local _g723 = sub(body, 0)
    setenv(name, {_stash = true, variable = true})
    if some63(_g723) then
      local _g724 = bind42(x, _g723)
      local args = _g724[1]
      local _g725 = _g724[2]
      return(join({"%local-function", name, args}, _g725))
    else
      return({"%local", name, x})
    end
  end}, ["define*"] = {export = true, macro = function (name, x, ...)
    local body = unstash({...})
    local _g726 = sub(body, 0)
    setenv(name, {_stash = true, global = true, export = true})
    if some63(_g726) then
      local _g727 = bind42(x, _g726)
      local args = _g727[1]
      local _g728 = _g727[2]
      return(join({"%global-function", name, args}, _g728))
    else
      if (target == "js") then
        return({"set", {"get", "global", {"quote", to_id(name)}}, x})
      else
        return({"set", name, x})
      end
    end
  end}, ["with-bindings"] = {export = true, macro = function (_g729, ...)
    local names = _g729[1]
    local body = unstash({...})
    local _g730 = sub(body, 0)
    local x = make_id()
    local _g732 = {"setenv", x}
    _g732.variable = true
    local _g731 = {"with-frame", {"each", {x}, names, _g732}}
    _g731.scope = true
    return(join(_g731, _g730))
  end}, ["let-macro"] = {export = true, macro = function (definitions, ...)
    local body = unstash({...})
    local _g733 = sub(body, 0)
    add(environment, {})
    map(function (m)
      return(macroexpand(join({"define-macro"}, m)))
    end, definitions)
    local _g734 = join({"do"}, macroexpand(_g733))
    drop(environment)
    return(_g734)
  end}, ["let-symbol"] = {export = true, macro = function (expansions, ...)
    local body = unstash({...})
    local _g735 = sub(body, 0)
    add(environment, {})
    map(function (_g737)
      local name = _g737[1]
      local exp = _g737[2]
      return(macroexpand({"define-symbol", name, exp}))
    end, pairwise(expansions))
    local _g736 = join({"do"}, macroexpand(_g735))
    drop(environment)
    return(_g736)
  end}, fn = {export = true, macro = function (args, ...)
    local body = unstash({...})
    local _g738 = sub(body, 0)
    local _g739 = bind42(args, _g738)
    local _g740 = _g739[1]
    local _g741 = _g739[2]
    return(join({"%function", _g740}, _g741))
  end}, guard = {export = true, macro = function (expr)
    if (target == "js") then
      return({{"fn", {}, {"%try", {"list", true, expr}}}})
    else
      local e = make_id()
      local x = make_id()
      local ex = ("|" .. e .. "," .. x .. "|")
      return({"let", {ex, {"xpcall", {"fn", {}, expr}, "%message-handler"}}, {"list", e, x}})
    end
  end}, each = {export = true, macro = function (b, t, ...)
    local body = unstash({...})
    local _g742 = sub(body, 0)
    local k = b[1]
    local v = b[2]
    local t1 = make_id()
    local _g765
    if nil63(v) then
      local _g766
      if b.i then
        _g766 = "i"
      else
        _g766 = make_id()
      end
      local i = _g766
      _g765 = {"let", {i, 0}, {"while", {"<", i, {"length", t1}}, join({"let", {k, {"at", t1, i}}}, _g742), {"inc", i}}}
    else
      local _g743 = {"target"}
      _g743.js = {"isNaN", {"parseInt", k}}
      _g743.lua = {"not", {"number?", k}}
      _g765 = {"let", {k, "nil"}, {"%for", t1, k, {"if", _g743, join({"let", {v, {"get", t1, k}}}, _g742)}}}
    end
    return({"let", {t1, t}, _g765})
  end}, ["set-of"] = {export = true, macro = function (...)
    local elements = unstash({...})
    local l = {}
    local _g744 = elements
    local _g745 = 0
    while (_g745 < length(_g744)) do
      local e = _g744[(_g745 + 1)]
      l[e] = true
      _g745 = (_g745 + 1)
    end
    return(join({"table"}, l))
  end}, language = {export = true, macro = function ()
    return({"quote", target})
  end}, target = {macro = function (...)
    local clauses = unstash({...})
    return(clauses[target])
  end, export = true, global = true}, ["join*"] = {export = true, macro = function (...)
    local xs = unstash({...})
    return(reduce(function (a, b)
      return({"join", a, b})
    end, xs))
  end}, ["join!"] = {export = true, macro = function (a, ...)
    local bs = unstash({...})
    local _g746 = sub(bs, 0)
    return({"set", a, join({"join*", a}, _g746)})
  end}, ["cat!"] = {export = true, macro = function (a, ...)
    local bs = unstash({...})
    local _g747 = sub(bs, 0)
    return({"set", a, join({"cat", a}, _g747)})
  end}, inc = {export = true, macro = function (n, by)
    return({"set", n, {"+", n, (by or 1)}})
  end}, dec = {export = true, macro = function (n, by)
    return({"set", n, {"-", n, (by or 1)}})
  end}, pr = {export = true, macro = function (...)
    local xs = unstash({...})
    local _g748 = map(function (x)
      return(splice({{"to-string", x}, "\" \""}))
    end, xs)
    return({"print", join({"cat"}, _g748)})
  end}, ["with-frame"] = {export = true, macro = function (...)
    local body = unstash({...})
    local _g749 = sub(body, 0)
    local scope = body.scope
    local x = make_id()
    local _g750 = {"table"}
    _g750._scope = scope
    return({"do", {"add", "environment", _g750}, {"let", {x, join({"do"}, _g749)}, {"drop", "environment"}, x}})
  end}}}, compiler = {import = {"runtime", "utilities", "special", "core", "reader"}, export = {["compile-body"] = {export = true, variable = true}, ["compile-call"] = {export = true, variable = true}, ["compile-function"] = {export = true, variable = true}, ["compile-special"] = {export = true, variable = true}, compile = {export = true, variable = true}, ["open-module"] = {export = true, variable = true}, ["load-module"] = {export = true, variable = true}, ["in-module"] = {export = true, variable = true}, ["compile-module"] = {export = true, variable = true}, eval = {export = true, variable = true}, infix = {variable = true}, getop = {variable = true}, ["infix?"] = {variable = true}, ["compile-args"] = {variable = true}, ["compile-atom"] = {variable = true}, terminator = {variable = true}, ["compile-infix"] = {variable = true}, ["can-return?"] = {variable = true}, lower = {variable = true, global = true, export = true}, ["lower-statement"] = {variable = true}, ["lower-do"] = {variable = true}, ["lower-if"] = {variable = true}, ["lower-while"] = {variable = true}, ["lower-for"] = {variable = true}, ["lower-function"] = {variable = true}, ["lower-definition"] = {variable = true}, ["lower-call"] = {variable = true}, ["lower-special"] = {variable = true}, process = {variable = true}, ["current-module"] = {global = true, export = true}, ["module-path"] = {variable = true}, encapsulate = {variable = true}, ["compile-file"] = {variable = true}, ["%result"] = {global = true, export = true}, run = {variable = true}, ["compiling?"] = {variable = true}, ["compiler-output"] = {variable = true}, ["%compile-module"] = {variable = true}, prologue = {variable = true}}}, system = {import = {"special", "core"}, export = {nexus = {global = true, export = true}}}}
  environment = {{["define-module"] = {export = true, macro = function (spec, ...)
    local body = unstash({...})
    local _g767 = sub(body, 0)
    local imports = {}
    local imp = _g767.import
    local exp = _g767.export
    local _g768 = (imp or {})
    local _g769 = 0
    while (_g769 < length(_g768)) do
      local k = _g768[(_g769 + 1)]
      load_module(k)
      imports = join(imports, imported(k))
      _g769 = (_g769 + 1)
    end
    modules[module_key(spec)] = {import = imp, export = {}}
    local _g770 = (exp or {})
    local _g771 = 0
    while (_g771 < length(_g770)) do
      local k = _g770[(_g771 + 1)]
      setenv(k, {_stash = true, export = true})
      _g771 = (_g771 + 1)
    end
    return(join({"do"}, imports))
  end}}}
end)();
(function ()
  local _g2 = nexus.runtime
  local nil63 = _g2["nil?"]
  local is63 = _g2["is?"]
  local length = _g2.length
  local none63 = _g2["none?"]
  local some63 = _g2["some?"]
  local hd = _g2.hd
  local string63 = _g2["string?"]
  local number63 = _g2["number?"]
  local boolean63 = _g2["boolean?"]
  local function63 = _g2["function?"]
  local composite63 = _g2["composite?"]
  local atom63 = _g2["atom?"]
  local table63 = _g2["table?"]
  local list63 = _g2["list?"]
  local substring = _g2.substring
  local sublist = _g2.sublist
  local sub = _g2.sub
  local inner = _g2.inner
  local tl = _g2.tl
  local char = _g2.char
  local code = _g2.code
  local string_literal63 = _g2["string-literal?"]
  local id_literal63 = _g2["id-literal?"]
  local add = _g2.add
  local drop = _g2.drop
  local last = _g2.last
  local reverse = _g2.reverse
  local join = _g2.join
  local reduce = _g2.reduce
  local keep = _g2.keep
  local find = _g2.find
  local pairwise = _g2.pairwise
  local iterate = _g2.iterate
  local replicate = _g2.replicate
  local splice = _g2.splice
  local map = _g2.map
  local keys63 = _g2["keys?"]
  local empty63 = _g2["empty?"]
  local stash = _g2.stash
  local unstash = _g2.unstash
  local extend = _g2.extend
  local exclude = _g2.exclude
  local search = _g2.search
  local split = _g2.split
  local cat = _g2.cat
  local _43 = _g2["+"]
  local _ = _g2["-"]
  local _42 = _g2["*"]
  local _47 = _g2["/"]
  local _37 = _g2["%"]
  local _62 = _g2[">"]
  local _60 = _g2["<"]
  local _61 = _g2["="]
  local _6261 = _g2[">="]
  local _6061 = _g2["<="]
  local read_file = _g2["read-file"]
  local write_file = _g2["write-file"]
  local write = _g2.write
  local exit = _g2.exit
  local parse_number = _g2["parse-number"]
  local to_string = _g2["to-string"]
  local apply = _g2.apply
  local make_id = _g2["make-id"]
  local _37message_handler = _g2["%message-handler"]
  local toplevel63 = _g2["toplevel?"]
  local module_key = _g2["module-key"]
  local module = _g2.module
  local setenv = _g2.setenv
  local _g5 = nexus.reader
  local make_stream = _g5["make-stream"]
  local read_table = _g5["read-table"]
  local read = _g5.read
  local read_all = _g5["read-all"]
  local read_from_string = _g5["read-from-string"]
  local _g6 = nexus.compiler
  local compile_body = _g6["compile-body"]
  local compile_call = _g6["compile-call"]
  local compile_function = _g6["compile-function"]
  local compile_special = _g6["compile-special"]
  local compile = _g6.compile
  local open_module = _g6["open-module"]
  local load_module = _g6["load-module"]
  local in_module = _g6["in-module"]
  local compile_module = _g6["compile-module"]
  local eval = _g6.eval
  local lower = _g6.lower
  local function rep(str)
    local _g774,_g775 = xpcall(function ()
      return(eval(read_from_string(str)))
    end, _37message_handler)
    local _g773 = {_g774, _g775}
    local _g1 = _g773[1]
    local x = _g773[2]
    if is63(x) then
      return(print((to_string(x) .. " ")))
    end
  end
  local function repl()
    local function step(str)
      rep(str)
      return(write("> "))
    end
    write("> ")
    while true do
      local str = (io.read)()
      if str then
        step(str)
      else
        break
      end
    end
  end
  local function usage()
    print((to_string("usage: lumen [options] <module>") .. " "))
    print((to_string("options:") .. " "))
    print((to_string("  -o <output>\tOutput file") .. " "))
    print((to_string("  -t <target>\tTarget language (default: lua)") .. " "))
    print((to_string("  -e <expr>\tExpression to evaluate") .. " "))
    return(exit())
  end
  local function main()
    local args = arg
    if ((hd(args) == "-h") or (hd(args) == "--help")) then
      usage()
    end
    local spec = nil
    local output = nil
    local target1 = nil
    local expr = nil
    local _g776 = args
    local i = 0
    while (i < length(_g776)) do
      local arg = _g776[(i + 1)]
      if ((arg == "-o") or (arg == "-t") or (arg == "-e")) then
        if (i == (length(args) - 1)) then
          print((to_string("missing argument for") .. " " .. to_string(arg) .. " "))
        else
          i = (i + 1)
          local val = args[(i + 1)]
          if (arg == "-o") then
            output = val
          else
            if (arg == "-t") then
              target1 = val
            else
              if (arg == "-e") then
                expr = val
              end
            end
          end
        end
      else
        if (nil63(spec) and ("-" ~= char(arg, 0))) then
          spec = arg
        end
      end
      i = (i + 1)
    end
    if output then
      if target1 then
        target = target1
      end
      return(write_file(output, compile_module(spec)))
    else
      in_module((spec or "main"))
      if expr then
        return(rep(expr))
      else
        return(repl())
      end
    end
  end
  main()
  local _g777 = {}
  nexus.main = _g777
  _g777.rep = rep
  _g777.repl = repl
  _g777.usage = usage
  _g777.main = main
end)();
