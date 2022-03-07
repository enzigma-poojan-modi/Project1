
function checkEmpty(){
var desc = document.getElementById('{!$Component.page.form.pageBlock.pbSection.desc}').value;
var postion  = document.getElementById('{!$Component.page.form.pageBlock.pbSection.postion}').value;
var expires = document.getElementById('{!$Component.page.form.pageBlock.pbSection.expires}').value;
var salary = document.getElementById('{!$Component.page.form.pageBlock.pbSection.salary}').value;
var manager = document.getElementById('{!$Component.page.form.pageBlock.pbSection.manager}').value;
var type = document.getElementById('{!$Component.page.form.pageBlock.pbSection.type}').value;
var skills = document.getElementById('{!$Component.page.form.pageBlock.pbSection.skills}').value;
var qualification = document.getElementById('{!$Component.page.form.pageBlock.pbSection.qualification}').value;
var certificate = document.getElementById('{!$Component.page.form.pageBlock.pbSection.certificate}').value;

if(desc == null || postion == null|| expires == null|| salary == null|| manager == null||type == null||skills == null ||qualification == null || certificate == null){
alert("Please enter details in each field");
}
else{
return true;
}
}
