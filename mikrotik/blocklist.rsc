#
# Many thanks to https://forum.mikrotik.com/t/turn-mikrotik-into-a-powerfull-firewall-with-blacklist-firehol/164932/1
# Also check https://help.mikrotik.com/docs/spaces/ROS/pages/328513/Building+Advanced+Firewall
#

ip firewall address-list
:local update do={
:do {
:local data ([:tool fetch url=$url output=user as-value]->"data")
remove [find list=blacklist comment=$description]
:while ([:len $data]!=0) do={
:if ([:pick $data 0 [:find $data "\n"]]~"^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}") do={
:do {add list=blacklist address=([:pick $data 0 [:find $data $delimiter]].$cidr) comment=$description timeout=1d} on-error={}
}
:if ([:pick $data 0 [:find $data "\n"]]~"[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?(\\/.*)?") do={
:do {add list=blacklist address=([:pick $data 0 [:find $data $delimiter]].$cidr) comment=$description timeout=1d} on-error={}
}
:set data [:pick $data ([:find $data "\n"]+1) [:len $data]]
}
} on-error={:log warning "Address list <$description> update failed"}
}
#$update url=https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_abusers_1d.netset description="firehol-firehol_abusers_1d" delimiter=("\n")
#$update url=https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_abusers_30d.netset description="firehol-firehol_abusers_30d" delimiter=("\n")
#$update url=https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_anonymous.netset description="firehol-firehol_anonymous" delimiter=("\n")
$update url=https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level1.netset description="firehol-firehol_level1" delimiter=("\n")
#$update url=https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level2.netset description="firehol-firehol_level2" delimiter=("\n")
#$update url=https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level3.netset description="firehol-firehol_level3" delimiter=("\n")
#$update url=https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_level4.netset description="firehol-firehol_level4" delimiter=("\n")
#$update url=https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_proxies.netset description="firehol-firehol_proxies" delimiter=("\n")
#$update url=https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_webclient.netset description="firehol-firehol_webclient" delimiter=("\n")
#$update url=https://raw.githubusercontent.com/firehol/blocklist-ipsets/master/firehol_webserver.netset description="firehol-firehol_webserver" delimiter=("\n")
