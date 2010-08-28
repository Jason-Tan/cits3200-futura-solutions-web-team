<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sempedia | Making computers think about data the way we do</title>
<link href="../css/styles.css" rel="stylesheet" type="text/css" />
<link href="../css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<script>
$(document).ready(function() {

	  $.ajax({
	        type: "GET",
	        url: "../ObjectAutoComplete",
	        success: function(data) {
	            var dataArray = data.split("|");
	          // alert(dataArray);
	            $("#object-name").autocomplete(dataArray);
	        }
	    });

	  $.ajax({
	        type: "GET",
	        url: "../ClassAutoComplete",
	        success: function(data2) {
	            var dataArray2 = data2.split("|");
	          // alert(dataArray);
	            $("#class-name").autocomplete(dataArray2);
	        }
	    });
	    
			$(".top-button").hover(
        	function() { $(this).addClass("top-button-active"); },
        	function() { $(this).removeClass("top-button-active"); }
    		);
						/////////////////////////											
			$("#object-created-panel").hide();						
			$("#create-object-btn").click(
        		function() { $("#object-created-panel").show("slow"); },
        		function() { $("#new-object-panel").hide(); } 				
			//	return: false;
			);
			$("#object-page-editor").hide();						
			$("#edit_object_page_btn").click(
        		function() { $("#object-page-editor").toggle("slow"); }
//        		function() { $("#new-object-panel").hide(); } 				
			//	return: false;
			);
			
			$("#add-tag").hide();						
			$("#add-tag-btn").click(
        		function() { $("#add-tag").toggle("fast"); }
			);
			
			$("#attach-class").click(
        		function() { 
					$("#class-row").prepend("<td nowrap='nowrap'>&nbsp;</td><td><span class='normal'><input name='class-type2' type='text' class='input-field' id='class-type2' size='24' /></span></td>"); }
			);
	});
</script>
<style type="text/css">
<!--
body {
	margin-top: 0px;
}
-->
</style></head>
<body>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td rowspan="2" valign="bottom" class="Header1"><a href="../index.jsp"><img src="../images/sempedia.jpg" alt="" width="299" height="60" border="0" /></a></td>
    <td width="90%" rowspan="2" valign="bottom" class="normal-small"><table border="0" cellspacing="8" cellpadding="6">
      <tr>
        <td width="52" class="normal-medium">&nbsp;</td>
        <td class="top-button"><a href="jsp/addClass.jsp" class="normal-medium">Add Class</a></td>
        <td class="top-button-active"><a href="jsp/addObject.jsp" class="normal-medium">Add Object </a></td>
      </tr>
    </table></td>
    <td align="right" class="Header1"><table border="0" cellspacing="0" cellpadding="8">
      <tr>
        <td align="right" bgcolor="#dedede" class="normal-small"><a class="normal-small-bold-link" href="">logout </a>| <a href="faq.html" class="normal-small-bold-link">faq</a> | <a href="about.html" class="normal-small-bold-link">about</a></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="right" nowrap="nowrap" class="Header1">
    <form method="post" name="seedSearch" action="SeedSearch">
      <label>
        <input type="text" class="normal" id="searchString" name="searchString" size="32"/>
        <input name="submit" type="submit" class="normal" id="submit" value="Search" />
      </label>
    </form></td>
  </tr>
</table>
<hr width="80%" size="1"/>
<form method="post" name="addObject" action="../AddObject">
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
  <tr>
    <td>
        <table width="100%" border="0" cellpadding="6" cellspacing="0" id="new-object-panel">
          <tr>
            <td colspan="2" nowrap="nowrap" class="header3" id="object-details">Details of New Object</td>
          </tr>
          <tr>
            <td width="8%" nowrap="nowrap"><span class="normal">Object Name</span></td>
            <td><span class="normal">
              <input name="object-name" type="text" id="object-name" size="40" class="input-field" />
            </span></td>
          </tr>
          <tr >
            <td colspan="2"><span class="comment-text"><strong>Newbie Help:</strong> If an appropriate class doesn't exist, write it's name here. It will then be created for you when you create the object. You can later navigate to the page you created for the class and add properties to it.</span></td>
          </tr>
          <tr >
            <td width="8%" nowrap="nowrap"><span class="normal">Is of type (class) </span></td>
            <td><span class="normal">
              <input name="class-name" type="text" class="input-field" id="class-name" size="24" />
            </span></td>
          </tr>
          <tr>
            <td width="8%" nowrap="nowrap">&nbsp;</td>
            <td id="object-create-link"><label>
              <input type="submit" name="create-object-btn" id="create-object-btn" value="Create Object" />
            </label></td>
          </tr>
        </table>
        <table width="100%" border="0" cellpadding="6" cellspacing="0" id="object-created-panel">
          <tr>
            <td width="90%" nowrap="nowrap">&nbsp;</td>
          </tr>
    </table></td>
  </tr>
</table>
</form>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#4C88BE"><img src="../images/1px-transparent.gif" width="1" height="1" alt="1px" /></td>
  </tr>
</table>
<table width="80%" border="0" align="center" cellpadding="8" cellspacing="0">
  <tr>
    <td class="normal-small">Created and maintained by <a href="http://www.ivec.org">iVEC</a> - The Hub of Advanced Computing in WA | Creative Commons License</td>
  </tr>
</table>
</body>
</html>
