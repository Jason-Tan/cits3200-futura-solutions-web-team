<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sempedia | Making computers think about data the way we
do</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.autocomplete.js"></script>
<script>
$(document).ready(function(){

	$(".top-button").hover( function() {
		$(this).addClass("top-button-active");
	}, function() {
		$(this).removeClass("top-button-active");
	});
	
	$.ajax({
    	type: "GET",
    	url: "ObjectAutoComplete",
    	success: function(data) {
       	 	var dataArray = data.split("|");
      	//	 alert(dataArray);
     	   $("#searchString").autocomplete(dataArray);
     	   $("#searchString2").autocomplete(dataArray);

	}
	});
});
</script>
<style type="text/css">
<!--
body {
	margin-top: 0px;
}
-->
</style>
</head>
<body>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    <td rowspan="2" valign="bottom" class="Header1"><a href="index.jsp">
    	<img src="images/sempedia.jpg" alt="" width="299" height="60" border="0" /></a>
    </td>
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
        		<td align="right" bgcolor="#dedede" class="normal-small"></td>
      		</tr>
    	</table>
	</td>
</tr>
<tr>
  <td align="right" nowrap="nowrap" class="Header1">
	<form method="get" name="seedSearch" action="SeedSearch">
      <label>
        <input type="text" class="ie6-input-text" name="searchString2" id="searchString2" size="32"/>
        <input  type="submit" class="ie6-submit-button"  value="Search" />
      </label>
    </form>
  </td>
</tr>
</table>
<hr width="80%" size="1" />
<table width="80%" border="0" align="center" cellpadding="8"
	cellspacing="0">
	<tr>
		<td width="10%" bgcolor="#F4F4F4">
		<form method="post" name="seedSearch" action="SeedSearch">
			<span class="Header2-black"><strong>Seed Search</strong></span>
			<p class="normal-small">Enter some search terms to start your semantic browsing session:</p>
		<input type="text" class="ie6-input-text" id="searchString" name="searchString" size="40" /> <input type="submit" class="ie6-submit-button" value="Search" /> <label> </label></form>
		</td>
	</tr>
</table>
	<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0" id="search_results">
	<tr>
		<td>
			<span class="grey-small"><strong>Newbie Help:</strong>
				If you click the icon <img src="images/icons/copper-file.png" alt="" width="16" height="16" /> you will be taken to the object/class page which provides descriptions and semantic tags.
			</span>
			<p></p>
			<p></p>
			<p></p>
			<p></p>
			<p></p>
		</td>
	</tr>
	</table>
	<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr><td bgcolor="#4C88BE"><img src="images/1px-transparent.gif" width="1" height="1" alt="1px" /></td></tr>
	</table>
	<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
		<tr><td class="normal-small">Created and maintained by <a href="http://www.ivec.org">iVEC</a> - The Hub of Advanced Computing in WA | Creative Commons License</td></tr>
	</table>
</body>
</html>