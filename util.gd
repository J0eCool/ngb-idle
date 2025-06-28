extends Node

func format(n: int) -> String:
	var arr = []
	while n >= 1000:
		var s = String.num_int64(n%1000)
		while s.length() < 3:
			s = "0"+s
		arr.append(s)
		n/=1000
	arr.append(String.num_int64(n))
	arr.reverse()
	return ",".join(arr)
