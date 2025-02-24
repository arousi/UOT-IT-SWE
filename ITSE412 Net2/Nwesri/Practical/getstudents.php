<?php
include "connection.php"; // connection to database
$name = $_POST['q'];
$query2 = "SELECT ID,name,password from student where name LIKE '$name%'";
try {
    $stmt = $conn->prepare($query2);
    $stmt->execute();
    $tablerows = '';
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $tablerows = "<tr>
            <td> " . $row['ID'] . "</td>
            <td>" . $row['name'] . "</td>
            <td> " . $row['password'] . "</td>
        </tr>";
    }
} catch (Exception $ex) {
    echo $ex->getMessage();
}
echo $tablerows;
