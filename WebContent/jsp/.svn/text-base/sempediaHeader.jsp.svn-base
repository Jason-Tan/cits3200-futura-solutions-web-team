<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sempedia | Making computers think about data the way we do</title>

<script>
function lookupLocal(){
	var oSuggest = $("#mainSearchForAjax")[0].autocompleter;
	oSuggest.findValue();
	return false;
}
$(document).ready(function() {
$("#mainSearchForAjax").autocomplete(
		"jsp/getPredicateValues.jsp",
		{
			delay:1,
			minChars:1,
			matchSubset:1,
			matchContains:1,
			cacheLength:10,
			autoFill:true,
			maxItemsToShow:10
		}
	);
	}); 
	</script>
</head>
<body>
	<tr>
    <td rowspan="2" valign="bottom" class="Header1"><a href="../index.html"><img src="../images/sempedia.jpg" alt="" width="299" height="60" border="0" /></a></td>
    <td width="90%" rowspan="2" valign="bottom" class="normal-small">
    <table border="0" cellspacing="8" cellpadding="6">
      <tr>
        <td width="52" class="normal-medium">&nbsp;</td>
        <td class="top-button"><a href="jsp/addClass.jsp" class="normal-medium">Add Class</a></td>
        <td class="top-button"><a href="jsp/addObject.jsp" class="normal-medium">Add Object </a></td>
      </tr>
    </table></td>
    <td align="right" class="Header1">
    <table border="0" cellspacing="0" cellpadding="8">
      <tr>
        <td align="right" bgcolor="#dedede" class="normal-small"><a href="a" class="normal-small-bold-link">ankur84</a>  | <span class="normal-bold"><a href="" class="normal-small-bold-link">logout</a></span> | <a href="" class="normal-small-bold-link">faq</a> | <a href="" class="normal-small-bold-link">about</a></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="right" nowrap="nowrap" class="Header1"><form method="post" name="sempediaHome" action="sempediaHome.htm?action=searchObjSemp">
      <label>
        <input type="text" class="ie6-input-text" name="objectNameSearch" id="mainSearchForAjax" size="32"/>
        <input  type="submit" class="ie6-submit-button"  value="Search" />
      </label>
    </form></td>
</tr>
</body>
</html>