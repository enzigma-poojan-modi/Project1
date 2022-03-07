function checkEmpty(){
var salutation = document.getElementById('salutation').value;
alert('This is first == '+desc);
var fname  = document.getElementById('{!$Component.page.form.pageBlock.pbSection.fname}').value;
alert('This is second == '+postion);
var lname = document.getElementById('{!$Component.page.form.pageBlock.pbSection.lname}').value;
var dob = document.getElementById('{!$Component.page.form.pageBlock.pbSection.dob}').value;
var email = document.getElementById('{!$Component.page.form.pageBlock.pbSection.email}').value;
var country = document.getElementById('{!$Component.page.form.pageBlock.pbSection.country}').value;
var state = document.getElementById('{!$Component.page.form.pageBlock.pbSection.state}').value;
var applicationdate = document.getElementById('{!$Component.page.form.pageBlock.pbSection.applicationdate}').value;
var status = document.getElementById('{!$Component.page.form.pageBlock.pbSection.status}').value;
var expectedsalary = document.getElementById('{!$Component.page.form.pageBlock.pbSection.expectedsalary}').value;
var job = document.getElementById('{!$Component.page.form.pageBlock.pbSection.job}').value;

if(salutation == null|| fname == null|| lname == null|| dob == null|| email == null||country == null||applicationdate == null ||status == null || expectedsalary == null || job == null){
alert("Please enter details in each field");
}
else{
return true;
}
}	