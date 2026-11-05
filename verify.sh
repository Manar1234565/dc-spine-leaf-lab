#!/usr/bin/env bash
P="clab-dc-spine-leaf"
echo "=== BGP sessions ==="
for n in spine1 spine2 leaf1 leaf2; do
  echo "--- $n ---"
  docker exec "$P-$n" vtysh -c "show bgp summary" | grep -E "10\.0\.|Neighbor"
done
echo; echo "=== ECMP on leaf1 (expect 2 next hops) ==="
docker exec "$P-leaf1" vtysh -c "show ip route 192.168.20.0/24"
echo; echo "=== Ping host1 -> host2 ==="
docker exec "$P-host1" ping -c 3 192.168.20.10
echo; echo "=== Traceroute host1 -> host2 ==="
docker exec "$P-host1" traceroute -n 192.168.20.10
