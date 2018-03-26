type status = {version: string, code: int} ;
datatype encoding = chuncked | compress | deflate | gzip | identity;
type date = {weekday: string, day: int, month: int, year: int, hour: int, minute:int, second:int};
datatype field =
      Server of string
    | ContentLength of int
	| TransferEncoding of encoding
	| Date of date
	| Expires of date
	| LastModified of date
	| Location of string
type response = {status: status, headers: field list, body:string};

val r = {
    status={version="HTTP/1.1", code=200},
    headers=[Server "nginx/1.6.2", ContentLength 12, TransferEncoding deflate,
			Date {weekday="Monday", day=26, month=3, year=2018, hour=15, minute=39, second=56}],
    body="hello world!"
}
;

fun encodingToString(e: encoding) : string = 
	(case (e) of 
		  chuncked => "chuncked"
		| compress => "compress"
		| deflate => "deflate"
		| gzip => "gzip"
		| identity => "identity"
	)
	;
	
fun dateToString(d: date) : string = 
	(#weekday d) ^ "," 
	^ Int.toString(#day d) ^ Int.toString(#month d) ^ Int.toString(#year d) 
	^ Int.toString(#hour d) ^":"^ Int.toString(#minute d) ^":"^ Int.toString(#second d) ^ (" GMT\n") 

fun fieldToString(f: field) : string = 
	(case (f) of 
		  Server s => "Server: " ^ s
		| ContentLength c => "Content-Length: " ^ Int.toString(c)
		| TransferEncoding a => "Transfer-Encoding: " ^ encodingToString(a)
		| Date a => "Date: " ^ dateToString(a)
		| Expires a => "Expires: " ^ dateToString(a)
		| LastModified a => "Last-Modified: " ^ dateToString(a)
		| Location a => "Location: " ^ a
		)
;
fun statusToString(s: status) : string = 
	(#version s) ^ " " ^ 
	(Int.toString(#code s)) ^ " " ^ 
	(case (#code s) of 200 => "OK" 
					| 301 => "Moved Permanently"
					| 404 => "Not found" 
					| _ => "")		
	;	
fun responseToString(r: response) : string = 
	statusToString(#status r)
	^ "\n"
	^ String.concatWith "\n" (map fieldToString (#headers r))
	^ "\n"
	^ (#body r)
	^ "\n"
	;

					
					