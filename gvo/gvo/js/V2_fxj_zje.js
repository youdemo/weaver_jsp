﻿jQuery(document).ready(
function() {
var bcbxje = "#field24469"; //本次报销金额
var bcfkje = "#field24470";//本次付款金额
var zje = "#field24471";//总金额
//alert(123456);

var bcbxje_val = jQuery(bcbxje).val();
var bcfkje_val = jQuery(bcfkje).val();
//alert("本次报销金额"+bcbxje_val);
//alert("本次付款金额"+bcfkje_val);
var zje_val = Math.max(bcbxje_val,bcfkje_val);
//alert("总金额="+zje_val);
jQuery(zje).val(zje_val);
});