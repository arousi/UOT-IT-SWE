<?php
include "connection.php"; //connect to the database and return $conn
try {

    $temp = $_POST["gridRadio"];
    $userID = $_POST['ID'];
    if ($temp == "option1") { 
        echo "<br>Entered insert block<br>";
        $query = "INSERT INTO t14db.userfinances(`UserName`, `Qs`, `UserID`) 
                                          VALUES(:UserName :Q, :ID)";
        $stmt = $conn->Prepare($query);

        $stmt->bindParam(':UserName', $_POST["UserName"]);
        $stmt->bindParam(':UserID', $_POST["ID"]);
        $stmt->bindParam(':Qs', $_POST["Q"]);

        if ($stmt->execute()) {
            echo "record added successfully";
            displayUserData($conn, $userID);
        }

    } elseif ($temp == "option2") {
        displayUserData($conn, $userID);
        $query = "update t14db.userfinances set `UserName`=:Username, Qs=:Q where UserID=:ID";
        $stmt = $conn->Prepare($query);
        $stmt->bindParam(':`UserID`', $_POST["ID"]);
        $stmt->bindParam(':`UserName`', $_POST["UserName"]);
        $stmt->bindParam(':`Qs`', $_POST["Q"]);
        if ($stmt->execute()) {
            echo "Data Changed successfully, here it is: <br>";
                displayUserData($conn, $userID);
        else
            echo "The ID is not found in the table";

        }
    } elseif ($temp == "option3") {
        displayUserData($conn, $userID);
        $query = "DELETE FROM t14db.userfinances WHERE UserID=:ID";
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
    $query = "SELECT `UserID`, `UserName`, `Qs` FROM userfinances WHERE `UserID` = :ID";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':ID', $userID, PDO::PARAM_STR);
    $stmt->execute();

    if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "--------------------------------------------<br>";
        echo "ID: " . $row['UserID'] . "<br>";
        echo "NAME: " . $row['UserName'] . "<br>";
        echo "Question: " . $row['Qs'] . "<br>";
        echo "--------------------------------------------<br>";
    } else {
        echo "--------------------------------------------<br>";
        echo "The ID is not found in the table";
        echo "--------------------------------------------<br>";
    }
}
$conn = null;