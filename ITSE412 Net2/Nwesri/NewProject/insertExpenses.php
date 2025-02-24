<?php
include "connection.php"; //connect to the database and return $conn
try {
    $temp = $_POST["gridRadio"];
    $userID = $_POST['UserID'];
    if ($temp == "option1") { // insert or add expense
        echo "<br>Entered insert block<br>";
        $query = "INSERT INTO t14db.userfinances (`UserName`, `Expense`, `UserID`) 
                  VALUES (:UserName, :Expense, :UserID)";
        $stmt = $conn->prepare($query);

        $stmt->bindParam(':UserName', $_POST["UserName"]);
        $stmt->bindParam(':Expense', $_POST["Expense"]);
        $stmt->bindParam(':UserID', $_POST["UserID"]);

        if ($stmt->execute()) {
            displayUserData($conn, $userID);
        } else {
            echo "Error executing the query.";
        }


    } elseif ($temp == "option2") {//edit or update expense
        displayUserData($conn, $userID);
        $query = "UPDATE t14db.userfinances
                 SET `UserName` = :UserName,
                     `Expense` = :Expense WHERE `UserID` = :UserID";
        $stmt = $conn->Prepare($query);

        $stmt->bindParam(':UserName', $_POST["UserName"]);
        $stmt->bindParam(':Expense', $_POST["Expense"]);
        $stmt->bindParam(':UserID', $_POST["UserID"]);


        if ($stmt->execute()) {
            echo "Data Changed successfully, here it is: <br>";
            displayUserData($conn, $userID);
        }
    } elseif ($temp == "option3") {//delete expense or record
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


function displayUserData($conn, $userID)
{
    echo "<br>Entered DisplayUserData<br>";
    $query = "SELECT `UserID`, `UserName`, `Expense` FROM userfinances WHERE `UserID` = :UserID";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':UserID', $userID, PDO::PARAM_STR);
    $stmt->execute();

    if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "--------------------------------------------<br>";
        echo "ID: " . $row['UserID'] . "<br>";
        echo "NAME: " . $row['UserName'] . "<br>";
        echo "Expense: " . $row['Expense'] . "<br>";
        echo "--------------------------------------------<br>";
    } else {
        echo "<br>--------------------------------------------";
        echo "The ID is not found in the table";
        echo "--------------------------------------------<br>";
    }
}
$conn = null;