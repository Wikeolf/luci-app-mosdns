local datatypes = require "luci.cbi.datatypes"

local white_list_file = "/etc/mosdns/rule/whitelist.txt"
local block_list_file = "/etc/mosdns/rule/blocklist.txt"
local grey_list_file = "/etc/mosdns/rule/greylist.txt"
local hosts_list_file = "/etc/mosdns/rule/hosts.txt"
local redirect_list_file = "/etc/mosdns/rule/redirect.txt"
local local_ptr_file = "/etc/mosdns/rule/local-ptr.txt"
local ddns_list_file = "/etc/mosdns/rule/ddnslist.txt"
local streaming_media_list_file = "/etc/mosdns/rule/streaming.txt"
local fakeip_list_file = "/etc/mosdns/rule/fakeiplist.txt"
local local_no_proxy_list_file = "/etc/mosdns/rule/local-no-proxy.txt"
local local_proxy_list_file = "/etc/mosdns/rule/local-proxy.txt"

m = Map("mosdns")

s = m:section(TypedSection, "mosdns", translate("Rule Settings"))
s.anonymous = true

s:tab("white_list", translate("White Lists"))
s:tab("block_list", translate("Block Lists"))
s:tab("grey_list", translate("Grey Lists"))
s:tab("ddns_list", translate("DDNS Lists"))
s:tab("hosts_list", translate("Hosts"))
s:tab("redirect_list", translate("Redirect"))
s:tab("local_ptr_list", translate("Block PTR"))
s:tab("streaming_media_list", translate("Streaming Media"))
s:tab("fakeip_list", translate("FakeIP Lists"))
s:tab("local_no_proxy_list", translate("Lan Proxy BlackList"))
s:tab("local_proxy_list", translate("Lan Proxy WhiteList"))

o = s:taboption("white_list", TextValue, "whitelist", "", "<font color='red'>" .. translate("These domain names allow DNS resolution with the highest priority. Please input the domain names of websites, every line can input only one website domain. For example: hm.baidu.com.") .. "</font>" .. "<font color='#00bd3e'>" .. translate("<br>The list of rules only apply to 'Default Config' profiles.") .. "</font>")
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section) return nixio.fs.readfile(white_list_file) or "" end
o.write = function(self, section, value) nixio.fs.writefile(white_list_file , value:gsub("\r\n", "\n")) end
o.remove = function(self, section, value) nixio.fs.writefile(white_list_file , "") end
o.validate = function(self, value)
    return value
end

o = s:taboption("block_list", TextValue, "blocklist", "", "<font color='red'>" .. translate("These domains are blocked from DNS resolution. Please input the domain names of websites, every line can input only one website domain. For example: baidu.com.") .. "</font>" .. "<font color='#00bd3e'>" .. translate("<br>The list of rules only apply to 'Default Config' profiles.") .. "</font>")
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section) return nixio.fs.readfile(block_list_file) or "" end
o.write = function(self, section, value) nixio.fs.writefile(block_list_file, value:gsub("\r\n", "\n")) end
o.remove = function(self, section, value) nixio.fs.writefile(block_list_file, "") end
o.validate = function(self, value)
    return value
end

o = s:taboption("grey_list", TextValue, "greylist", "", "<font color='red'>" .. translate("These domains are always resolved using remote DNS. Please input the domain names of websites, every line can input only one website domain. For example: google.com.") .. "</font>" .. "<font color='#00bd3e'>" .. translate("<br>The list of rules only apply to 'Default Config' profiles.") .. "</font>")
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section) return nixio.fs.readfile(grey_list_file) or "" end
o.write = function(self, section, value) nixio.fs.writefile(grey_list_file, value:gsub("\r\n", "\n")) end
o.remove = function(self, section, value) nixio.fs.writefile(grey_list_file, "") end
o.validate = function(self, value)
    return value
end

o = s:taboption("ddns_list", TextValue, "ddns", "", "<font color='red'>" .. translate("These domains are always resolved using local DNS. And force TTL 5 seconds, DNS resolution results will not enter the cache. For example: myddns.example.com.") .. "</font>" .. "<font color='#00bd3e'>" .. translate("<br>The list of rules only apply to 'Default Config' profiles.") .. "</font>")
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section) return nixio.fs.readfile(ddns_list_file) or "" end
o.write = function(self, section, value) nixio.fs.writefile(ddns_list_file, value:gsub("\r\n", "\n")) end
o.remove = function(self, section, value) nixio.fs.writefile(ddns_list_file, "") end
o.validate = function(self, value)
    return value
end

o = s:taboption("hosts_list", TextValue, "hosts", "", "<font color='red'>" .. translate("Hosts For example: baidu.com 10.0.0.1") .. "</font>" .. "<font color='#00bd3e'>" .. translate("<br>The list of rules only apply to 'Default Config' profiles.") .. "</font>")
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section) return nixio.fs.readfile(hosts_list_file) or "" end
o.write = function(self, section, value) nixio.fs.writefile(hosts_list_file, value:gsub("\r\n", "\n")) end
o.remove = function(self, section, value) nixio.fs.writefile(hosts_list_file, "") end
o.validate = function(self, value)
    return value
end

o = s:taboption("redirect_list", TextValue, "redirect", "", "<font color='red'>" .. translate("The domain name to redirect the request to. Requests domain A, but returns records for domain B. example: a.com b.com") .. "</font>" .. "<font color='#00bd3e'>" .. translate("<br>The list of rules only apply to 'Default Config' profiles.") .. "</font>")
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section) return nixio.fs.readfile(redirect_list_file) or "" end
o.write = function(self, section, value) nixio.fs.writefile(redirect_list_file, value:gsub("\r\n", "\n")) end
o.remove = function(self, section, value) nixio.fs.writefile(redirect_list_file, "") end
o.validate = function(self, value)
    return value
end

o = s:taboption("local_ptr_list", TextValue, "local_ptr", "", "<font color='red'>" .. translate("These domains are blocked from PTR requests") .. "</font>" .. "<font color='#00bd3e'>" .. translate("<br>The list of rules only apply to 'Default Config' profiles.") .. "</font>")
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section) return nixio.fs.readfile(local_ptr_file) or "" end
o.write = function(self, section, value) nixio.fs.writefile(local_ptr_file, value:gsub("\r\n", "\n")) end
o.remove = function(self, section, value) nixio.fs.writefile(local_ptr_file, "") end
o.validate = function(self, value)
    return value
end

o = s:taboption("streaming_media_list", TextValue, "streaming_media", "", "<font color='red'>" .. translate("These domains are always resolved using Streaming Media DNS. Please input the domain names of websites, every line can input only one website domain. For example: netflix.com.") .. "</font>" .. "<font color='#00bd3e'>" .. translate("<br>The list of rules only apply to 'Default Config' profiles.") .. "</font>")
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section) return nixio.fs.readfile(streaming_media_list_file) or "" end
o.write = function(self, section, value) nixio.fs.writefile(streaming_media_list_file, value:gsub("\r\n", "\n")) end
o.remove = function(self, section, value) nixio.fs.writefile(streaming_media_list_file, "") end
o.validate = function(self, value)
    return value
end

o = s:taboption("fakeip_list", TextValue, "fakeip", "", "<font color='red'>" .. translate("These domains are always resolved using FakeIP DNS. Please input the domain names of websites, every line can input only one website domain. For example: v2.hysteria.network.") .. "</font>" .. "<font color='#00bd3e'>" .. translate("<br>The list of rules only apply to 'Default Config' profiles.") .. "</font>")
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section) return nixio.fs.readfile(fakeip_list_file) or "" end
o.write = function(self, section, value) nixio.fs.writefile(fakeip_list_file, value:gsub("\r\n", "\n")) end
o.remove = function(self, section, value) nixio.fs.writefile(fakeip_list_file, "") end
o.validate = function(self, value)
    return value
end

o = s:taboption("local_no_proxy_list", TextValue, "local_no_proxy", "", "<font color='red'>" .. translate("These ips are always resolved using True IP DNS. Please input as CIDR format") .. "</font>" .. "<font color='#00bd3e'>" .. translate("<br>The list of rules only apply to 'Default Config' profiles.") .. "</font>")
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section) return nixio.fs.readfile(local_no_proxy_list_file) or "" end
o.write = function(self, section, value) nixio.fs.writefile(local_no_proxy_list_file, value:gsub("\r\n", "\n")) end
o.remove = function(self, section, value) nixio.fs.writefile(local_no_proxy_list_file, "") end
o.validate = function(self, value)
    return value
end

o = s:taboption("local_proxy_list", TextValue, "local_proxy", "", "<font color='red'>" .. translate("These ips are always resolved using Fake IP DNS. Please input as CIDR format") .. "</font>" .. "<font color='#00bd3e'>" .. translate("<br>The list of rules only apply to 'Default Config' profiles.") .. "</font>")
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section) return nixio.fs.readfile(local_proxy_list_file) or "" end
o.write = function(self, section, value) nixio.fs.writefile(local_proxy_list_file, value:gsub("\r\n", "\n")) end
o.remove = function(self, section, value) nixio.fs.writefile(local_proxy_list_file, "") end
o.validate = function(self, value)
    return value
end

local apply = luci.http.formvalue("cbi.apply")
if apply then
    luci.sys.exec("/etc/init.d/mosdns reload")
end

return m
