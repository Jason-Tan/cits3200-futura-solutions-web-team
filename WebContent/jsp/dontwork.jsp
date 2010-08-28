<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="model.TriplePOJO"%>
<%@ page import="dao.PredicateDao"%>
<%@ page import="dao.ObjectDao;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sempedia | Making computers think about data the way we do</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script>
	$(document).ready( function() {	
		var queryPreds = new Array();	// this contains the predicates that form the query
		var queryObjs = new Array();	// this contains the objects that match predicates to form the query
		//var predQuery = new Array();	// this tells you at what location a given predicate Id is in the queryPreds array
											// this should not really be needed some Array.size() method should be available to be used in its place
		var queryString="";		//make this global because I am a fool and can't seem to pass variables to JavaScript functions

		function countObjs(){
			alert("Got here");
			var variables = queryPreds.length;
			queryString="count="+variables;
			//alert(variables);
			for(var i=1; i<=variables;i++){   
				if((queryPreds[i]=="")||(typeof(queryPreds[i])=='undefined')){}
				else 
					{
						queryString=queryString+"&preId"+i+"="+queryPreds[i]+"&objId"+i+"="+queryObjs[i];
					}
			}
			
			alert(queryString);
			//send the queryString to the servlet that does the counting
			$.ajax( {
				type : "GET",
				url : "ObjectCount",
				dataType: 'json',
				data : queryString,
				success : function(data) {
					 $("#queryCount").html("<p><span class='Header1'><b>"+data+"</span></p>");	
					 //if("#results:has(form.getObjects)"){
					 //}
					 //else{
					// 	$("#results").append("<input type='submit' value='Get Objects' class='getObjects' />");	
					// }
				}
			});
			queryString="";
		}

	//	function getCount(){
	//		var variables = queryPreds.length;
	//		//alert(variables);
	//		queryString="count="+variables;
	//		for(var i=1; i<=variables;i++){
	//			    //$("#displayQuery").append(i+" - "+queryPreds[i]+" - "+queryObjs[i]+" <br>");
	//			    queryString=queryString+"&preId"+i+"="+queryPreds[i]+"&objId"+i+"="+queryObjs[i];
	//			    alert(queryPreds[i]);
	//		}
	//		//send the queryString to the servlet that does the counting
	//		$.ajax( {
	//			type : "GET",
		//		url : "ObjectQuery",
			//	dataType: 'json',
	//			data : queryString,
	//			success : function(resultObj) {
	//				  $.each(resultObj, function(i,value) {
	//					 $("#resultCount").prepend("<a class='result' href='ObjectPage?id="+resultObj[i].id+"'><div id='"+resultObj[i].id+"'>"+resultObj[i].name+"</div></a>");
	//			         });
	//				}
	//		});
	//		queryString="";
	//	}

		function retrieveObjects(){
			var variables = queryPreds.length;
			queryString="count="+variables;
			for(var i=1; i<=variables;i++){
			    if((queryPreds[i]=="")||(typeof(queryPreds[i])=='undefined')){
				}
				else{
				    queryString=queryString+"&preId"+i+"="+queryPreds[i]+"&objId"+i+"="+queryObjs[i];
					}
				}
			//send the queryString to the servlet that does the counting
			$.ajax( {
				type : "GET",
				url : "ObjectQuery",
				dataType: 'json',
				data : queryString,
				success : function(resultObj) {
					  $.each(resultObj, function(i,value) {
						 $("#resultCount").prepend("<a class='result' href='ObjectPage?id="+resultObj[i].id+"'><div id='"+resultObj[i].id+"'>"+resultObj[i].name+"</div></a>");	
				         });
					}
				});
			queryString="";
		}

		function arrayContains(a,obj) {
			  var i = a.length;
			  while (i--) {
			    if (a[i] === obj) {
			      return true;
			    }
			  }
			  return false;
			}

		function indexPos(arr, obj) {
			  for(var i=0; i<arr.length; i++) {
			    if (arr[i] == obj) return i;
			  }
			}

		$(".predicate").click( function() {

			var preId = this.id;
			var objId ="-1";
			var preName = $(".predName").filter("[preId='"+preId+"']").attr('preName');

			if(arrayContains(queryPreds,preId)){
				//if the predicate array contains this predicate - then we get it's index and force the object to be -1
				var arrayPos = indexPos(queryPreds, preId);
				queryObjs[arrayPos] = -1;
			}	else{
				queryPreds[queryPreds.length] = preId;
				queryObjs[queryPreds.length] = objId;
				}
			
				if(queryPreds.length==1){ // display the query ... we do the long version here as it's possibly the first click
 					$("#displayQuery").append("<span class='normal-small'>Your query is as follows:</span>");
					$("#displayQuery").append("<p class='queryItem' predId='"+preId+"'><span class='normal-small'><b>"+preName+"</b> equals anything <img class='deleteQueryItem' predId='"+preId+"' src='images/close.gif' height='9' width='9'/></span></p>");
					}
					else{
						$("#displayQuery").append("<p class='queryItem' predId='"+preId+"'><span class='normal-small'><b>"+preName+"</b> equals anything <img class='deleteQueryItem' predId='"+preId+"' src='images/close.gif' height='9' width='9'/></span></p>");
					}
				$(".queryItem").filter("[predId='"+preId+"']").replaceWith("<p class='queryItem' predId='"+preId+"'><span class='normal-small'><b>"+preName+"</b> equals anything <img src='images/close.gif' class='deleteQueryItem' predId='"+preId+"' height='9' width='9'/></span></p>");

				countObjs();
		});
		
		$(".object").click( function() {

			var preId = $(this).attr('preId');
			var objId = this.id;
			var preName = $(".predName").filter("[preId='"+preId+"']").attr('preName');
			var objName = $(".objectName").filter("[objId='"+objId+"']").attr('objName');

			for(var i=1; i<=queryPreds.length;i++){
			    //$("#displayQuery").append(i+" - "+queryPreds[i]+" - "+queryObjs[i]+" <br>")
			    alert(queryPreds[i]);
		}
			
			alert(preId+" -- "+objId);
			if(arrayContains(queryPreds,preId)){
				//if the predicate array contains this predicate - then we get it's index and force the object to be -1
				var arrayPos = indexPos(queryPreds, preId);
				queryObjs[arrayPos] = -1;
			}	else{
					queryPreds[queryPreds.length+1] = preId;
					queryObjs[queryPreds.length+1] = objId;
				}

				if(queryPreds.length==1){ // display the query ... we do the long version here as it's possibly the first click
 					$("#displayQuery").append("<span class='normal-small'>Your query is as follows:</span>");
					$("#displayQuery").append("<p class='queryItem' predId='"+preId+"'><span class='normal-small'><b>"+preName+"</b> equals <b>"+objName+"</b> <img class='deleteQueryItem' predId='"+preId+"' src='images/close.gif' height='9' width='9'/></span></p>");
					}
					else{
						$("#displayQuery").append("<p class='queryItem' predId='"+preId+"'><span class='normal-small'><b>"+preName+"</b> equals <b>"+objName+"</b> <img class='deleteQueryItem' predId='"+preId+"' src='images/close.gif' height='9' width='9'/></span></p>");
					}
					$(".queryItem").filter("[predId='"+preId+"']").replaceWith("<p class='queryItem' predId='"+preId+"'><span class='normal-small'><b>"+preName+"</b> equals <b>"+objName+"</b> <img class='deleteQueryItem' predId='"+preId+"' src='images/close.gif' height='9' width='9'/></span></p>");

					countObjs();
		});
			
//		function getResults(){
//			$.ajax( {
//				type : "GET",
//				url : "ObjectCount",
//				dataType: 'json',
//				data : queryString + "count=" + variables,
//				success : function(resultObj) {
//				  $.each(resultObj, function(i,value) {
//					 $("#resultCount").prepend("<a class='result' href='ObjectPage?id="+resultObj[i].id+"'><div id='"+resultObj[i].id+"'>"+resultObj[i].name+"</div></a>");	
//			         });
//				}
//			});
//			queryString="";
//			variables=0;
//		}
		
		function getPreName(preId){
			alert("fdsfds");
			var preName ="";
			$.ajax( {
				type : "GET",
				url : "Predicate",
				dataType: 'json',
				data : "preId="+preId,
				success : function(data) {
				preName = data;
				}
			});
			return preName;
		}

		function remFromQuery(predicate, array1, array2) {
		    for(var i=0; i<arrayName.length;i++ )
		     { 
		        if(queryPreds[i]==predicate)
		        	array1.splice(i,1);
		        	array2.splice(i,1);
		      }
		  }			

	$(".deleteQueryItem").live('click',function() {
		//remove the item from the two main arrays
		// remove the item from the support array
		//remove the item from the screen
		var variables = queryPreds.length;
		var preId = $(this).attr('predId');
		//	alert(preId);
		$(".queryItem").filter("[predId='"+preId+"']").remove();
		//var countVal = predQuery[preId];
		//queryPreds[countVal]="";
		//queryObjs[countVal]="";
		remFromQuery(preId, queryPreds, queryObjs);
		//predQuery[preId]=""; //track this	
		getCount();
		});	
	});
</script>
</head>
<body>
<form id="object">
<%
	ArrayList<TriplePOJO> triples = new ArrayList<TriplePOJO>();
	triples = (ArrayList<TriplePOJO>) request.getAttribute("triples");
	PredicateDao pdao = new PredicateDao();
	ObjectDao odao = new ObjectDao();
	
	Iterator<TriplePOJO> itr2 = triples.iterator();
	while(itr2.hasNext()){
		TriplePOJO theTriple = new TriplePOJO();
		theTriple = itr2.next();
	%>
		<input type="hidden" class="objectName" objId="<% out.print(theTriple.getObjId()); %>" objName="<% out.print(odao.getObjectName(theTriple.getObjId())); %>" />
		<input type="hidden" class="predName" preId="<% out.print(theTriple.getPreId()); %>" preName="<% out.print(pdao.getPredName(theTriple.getPreId())); %>" />
	<%
		}
	%>
</form>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td rowspan="2" valign="bottom" class="Header1">
		<a href="index.jsp"><img src="images/sempedia.jpg" alt="" width="299" height="60" border="0" /></a></td>
		<td width="90%" rowspan="2" valign="bottom" class="normal-small">
		<table border="0" cellspacing="8" cellpadding="6">
			<tr>
				<td width="52" class="normal-medium">&nbsp;</td>
				<td class="top-button"><a href="jsp/addClass.jsp" class="normal-medium">Add Class</a></td>
				<td class="top-button"><a href="jsp/addObject.jsp" class="normal-medium">Add Object </a></td>
			</tr>
		</table>
		</td>
		<td align="right" class="Header1">
		<table border="0" cellspacing="0" cellpadding="8">
			<tr>
				<td align="right" bgcolor="#dedede" class="normal-small">
				<a href="faq.html" class="normal-small-bold-link">faq</a> |
				<a href="about.html" class="normal-small-bold-link">about</a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="right" nowrap="nowrap" class="Header1">
		<form method="post" action="SeedSearch"><label>
			<input type="text" class="normal" id="search_box2" size="32" />
			<input name="submit2" type="submit" class="normal" id="submit2" value="Search" />
		</label>
		</form>
		</td>
	</tr>
</table>
<hr width="80%" size="1" />
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
	<tr>
		<td valign="top"><strong><span class="Header2-black" id="object-name">
		<% out.print((String) request.getAttribute("objectName")); %>
		</span></strong>
		<%
			HashMap<Integer, String> classes = new HashMap<Integer, String>();
		 	classes = (HashMap<Integer, String>) request.getAttribute("classes");
		 	if (!(classes.size() == 0)) {
	 		out.print("<span class='normal-small'>is a </span>");
 			}
		 	Set<Integer> classids = new HashSet<Integer>();
		 	classids = classes.keySet();
		 	Iterator<Integer> itr1 = classids.iterator();
		 	while (itr1.hasNext()) {
	 		int classId = itr1.next();
 		%>
 		<strong>
 		  <span id="class-name">
 		    <a href="ClassPage?classId=<%  out.print(classId);  %>" class="small-link">
		<%  out.print(classes.get(classId));  %>
		</a>
		</span>
		</strong>
		<%
 			}
 		%>
		</td>
		<td align="right" valign="top">
		<table border="0" cellspacing="0" cellpadding="4">
			<tr>
				<td class="normal-small"><a href="EditObject?id=<%out.print(request.getAttribute("objId"));%>"><img src="images/edit.gif" alt="" width="19" height="19" /></a></td>
				<td class="normal-small"><span class="small-link">
					<a href="EditObject?id=<%out.print(request.getAttribute("objId"));%>">Edit This Page</a></span></td>
			</tr>
		</table>
		</td>
		<!--  this HTML is fine -->
	</tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0" id="object-panel">
	<tr><td width="178" valign="top">
		<p class="normal-small"><img src="pics/<%out.print(request.getAttribute("imgCaption"));%>" width="180" height="240" /><br />
		</p>
		  <table border="0" cellspacing="0" cellpadding="2">
			<tr>
			  <td>
				<span class="normal-small">
				  <% request.getAttribute("imgCaption"); %>
				</span>
			  </td>
			</tr>
		  </table>
		</td>
		<td colspan="2" valign="top">
		<p class="normal-small">
			<% out.print(request.getAttribute("text")); %>
		</p>
		</td>
	</tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
	<tr>
		<td><span class="Header2-black">Semantic Browse</span>
		<form method="get" name="addTripleForm" action="AddTriple">
		<input type="hidden" id="subId" name="subId" value="<% out.print(request.getAttribute("objId")); %>" />
		<table border="0" cellspacing="0" cellpadding="6" id="add-tag">
			<tr>
				<td valign="top" nowrap="nowrap"><span class="normal-small">Property</span></td>
				<td valign="top" nowrap="nowrap"><span class="normal-small">Value</span></td>
			</tr>
			<tr id="add-property">
				<td valign="top" nowrap="nowrap"><input type="text" name="predicate" id="predicate" class="normal" /> <br />
				</td>
				<td valign="top" nowrap="nowrap"><span class="normal-small">
				<input type="text" name="object" id="object" class="normal" /></span>
				<input type="submit" name="button" id="button" value="Save" />
				<input type="button" name="cancel-add" id="cancel-add" value="Cancel" /></td>
			</tr>
		</table>
		</form></td>
	</tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
	<!-- <tr>
		<td width="40%" height="100%" colspan="2" valign="top"><span class="normal">
		<input type="submit" id="add-tag-btn" value="+ Add a Semantic Tag" /> </span></td>
	</tr> -->
	<tr>
		<td height="100%" colspan="2" valign="top" width="15%">
		
		<table border="0" cellspacing="0" cellpadding="4" id="semtag">
			<%
				Iterator<TriplePOJO> itr = triples.iterator();
				while (itr.hasNext()) {
					TriplePOJO atriple = new TriplePOJO();
					atriple = itr.next();
			%>
			<tr>
				<td nowrap="nowrap">
				<div class="predicate" id="<% out.print(atriple.getPreId()); %>">
				<span class="normal">
				<%
					out.print(pdao.getPredName(atriple.getPreId()));
				%>
				</span></div>
				</td>
				<td><img src="images/right.jpg" alt="-" width="16" height="10" /></td>
				<td nowrap="nowrap">
				<div class="object" id="<% out.print(atriple.getObjId());%>" preId="<% out.print(atriple.getPreId()); %>">
				<span class="normal">
				<%
					out.print(odao.getObjectName(atriple.getObjId()));
				%>
				</span></div>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		</td>
		<td valign="top">
		<div>
			<table cellpadding="4" cellspacing="0" border="0" bgcolor="FFFFFF">
			  <tr>
				<td id="queryCount"></td>
				<td id="displayQuery"></td>
				<td id="objectList"></td>
			  </tr>	
			  <tr>
				<td></td>
				<td colspan="2" id="results"></td>
			  </tr>
			</table>
		</div>
		</td>
	</tr>
</table>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr><td bgcolor="#4C88BE"><img src="images/1px-transparent.gif" width="1" height="1" alt="1px" /></td></tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
	<tr><td class="normal-small">&copy; Sempedia 2009 | Creative Commons License</td></tr>
</table>
<p>&nbsp;</p>
</body>
</html>