<?php
include "connection.php"; //connect to the database and return $conn
try {

    $temp = $_POST["gridRadio"];
    $userID = $_POST[`UserID`];
    if ($temp == "option1") { //insert or add Dept
        echo "<br>Entered insert block<br>";
        $query = "INSERT INTO t14db.userfinances(`UserName`, `Dept`, `UserID`) 
                                    VALUES(:UserName, :Dept, :UserID)";
        $stmt = $conn->Prepare($query);

        $stmt->bindParam(":UserName", $_POST[`UserName`]);
        $stmt->bindParam(":Dept", $_POST[`Dept`]);
        $stmt->bindParam(":UserID", $_POST[`UserID`]);


        if ($stmt->execute()) {
            echo "record added successfully";
            /*$userID = $_POST['UserID'];//print data before deleting, i should make it a function display($UserID);

            $query2 = "SELECT ID,User-Name,Dept from t14-db where ID = 'UserID'";
            $stmt = $conn->prepare($query2);
            $stmt->execute();
            if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                echo "ID: " . $row['ID'] . "<br>";
                echo "NAME: " . $row['User-Name'] . "<br>";
                echo "Expence: " . $row['Dept'] . "<br>";
            } else
                echo "The ID is not found in the table";//end of print UserID row*/
            displayUserData($conn, $userID);
        }

    } elseif ($temp == "option2") {//edit or update Dept

        /*$userID = $_POST['UserID'];//print data before deleting, i should make it a function display($UserID);
        $query2 = "SELECT ID,User-Name,Dept from t14-db where ID = 'UserID'";
        $stmt = $conn->prepare($query2);
        $stmt->execute();
        if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            echo "ID: " . $row['ID'] . "<br>";
            echo "NAME: " . $row['User-Name'] . "<br>";
            echo "Expence: " . $row['Dept'] . "<br>";
        } else
            echo "The ID is not found in the table";//end of print UserID row*/

        displayUserData($conn, $userID);
        $query = "update t14db.userfinances set UserName=:Username, Dept=:Dept where UserID=:UserID";
        $stmt = $conn->Prepare($query);
        $stmt->bindParam(':UserID', $_POST["UserID"]);
        $stmt->bindParam(':UserName', $_POST["UserName"]);
        $stmt->bindParam(':Dept', $_POST["Dept"]);
        if ($stmt->execute()) {
            echo "Data Changed successfully, here it is: <br>";

            $userID = $_POST['UserID'];
            $query2 = "SELECT ID, UserName, Dept from userfincaces where UserID = 'UserID'";
            $stmt = $conn->prepare($query2);
            $stmt->execute();
            if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                echo "ID: " . $row['UserID'] . "<br>";
                echo "NAME: " . $row['UserName'] . "<br>";
                echo "Dept: " . $row['Dept'] . "<br>";
            } else
                echo "The ID is not found in the table";

        }
    } elseif ($temp == "option3") {//delete Dept or record

        /* $userID = $_POST['UserID'];//print data before deleting, i should make it a function display($UserID);
         $query2 = "SELECT ID,User-Name,Dept from t14-db where ID = 'UserID'";
         $stmt = $conn->prepare($query2);
         $stmt->execute();
         if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
             echo "ID: " . $row['ID'] . "<br>";
             echo "NAME: " . $row['User-Name'] . "<br>";
             echo "Expence: " . $row['Dept'] . "<br>";
         } else
             echo "The ID is not found in the table";//end of print UserID row*/

        displayUserData($conn, $userID);
        $query = "DELETE FROM t14db.userfinances WHERE UserID=:UserID";//Now Delete
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':UserID', $userID);
        if ($stmt->execute()) {
            echo "record Deleted Successfully";
        }
    }



} catch (Exception $ex) {
    echo $ex->getMessage();
}
function displayUserData($conn, $userID){
    echo "<br>Entered DisplayUserData<br>";
    $query = "SELECT UserID, UserName, Dept FROM userfinances WHERE UserID = :UserID";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':UserID', $userID, PDO::PARAM_STR);
    $stmt->execute();

    if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "--------------------------------------------<br>";
        echo "ID: " . $row['UserID'] . "<br>";
        echo "NAME: " . $row['UserName'] . "<br>";
        echo "Dept: " . $row['Dept'] . "<br>";
        echo "--------------------------------------------";
    } else {
        echo "--------------------------------------------";
        echo "The ID is not found in the table";
        echo "--------------------------------------------";
    }
}
$conn = null;