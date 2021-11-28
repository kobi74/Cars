<%@ Page Title="" Language="C#" MasterPageFile="~/FrontendMasterPage.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Cars.About" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    אודות
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentBody" runat="server">
  <div class="w3-row w3-padding-64" id="about">

    <div class="w3-col m6 w3-padding-large">
      <h1 class="w3-center">אודות Cars</h1><br>
      <h5 class="w3-center">השוואת מחירים בין סוכנויות ליסינג</h5>
      <p class="w3-large">
          אתר Cars הוא מיזם חדש בתחום קניית רכב יד שניה מליסינג.
          סוכנויות הליסינג מפעילות אתרי אינטרנט שם הן מציעות מכוניות מיד שניה למכירה.
          במקום לחפש רכבים ולהשוות מחירים בין האתרים,Cars עושה בעבורכם את העבודה ומשווה במהירות מחירים בין עשרות סוכנויות הליסינג.
      </p>
    <p class="w3-large">
        במקום לחפש שעות ולבזבז כסף, באתר Cras תוכלו למצוא את הרכב האידיאלי במחיר הטוב ביותר.
        בCars תקבלו מידע מלא על הרכב שאתם מחפשים ובנוסף תוכלו לראות את שם הסוכנות והסניף המציעים את הרכב.
    </p>
        <p class="w3-large">
            ראיתם רכב שמוצא חן בעינכם? מעולה! תוכלו לקבוע פגישה בסניף של הסוכנות כדי לשמוע פרטים נוספים על הרכב.
            <br />
            <span class="w3-tag w3-light-grey">הרכב לא נמצא בסניף באזור מגוריכם?</span> לא נורא, Cars מרכז את כל סניפי סוכנויות הליסינג ותוכלו לקבוע פגישה בסניף הסוכנות הקרוב אליכם.
        </p>
        <h5 class="w3-center">יעדים עיקריים</h5>
        <ul>
            <li class="w3-large w3-text-grey w3-hide-medium">חשיפת רכבים של הסוכנויות לקהל רחב יותר.</li>
            <li class="w3-large w3-text-grey w3-hide-medium">חשיפת לקוחות לסוכנויות הרכב.</li>
            <li class="w3-large w3-text-grey w3-hide-medium">השוואת מחירים -  לקוחות נחשפים למחירים ולמבצעים עבור הרכב או התקציב.</li>
            <li class="w3-large w3-text-grey w3-hide-medium">חוסך מהלקוחות את הסיור הרגלי בין הסוכנויות וגם את תהליך השוואת המחירים בין האתרים</li>
        </ul>
    </div>
    <div class="w3-col m6 w3-padding-large w3-hide-small">
     <img src="images/logo.png" class="w3-round w3-image w3-opacity-min" alt="Table Setting" width="600" height="750">
    </div>

  </div>
  
  <hr>
</asp:Content>
