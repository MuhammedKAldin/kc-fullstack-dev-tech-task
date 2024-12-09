<?php
// api/v1/getCourses.php
declare(strict_types=1);

error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include_once 'config/database.php';

$database = new Database();
$db = $database->getConnection();

if ($db === null) {
    http_response_code(500);
    echo json_encode(["error" => "Database connection failed."]);
    exit;
}

try {
    // Check if an 'id' parameter is provided
    $id = isset($_GET['id']) ? $_GET['id'] : null;

    // If 'id' is provided, get the specific course; otherwise, get all courses
    if ($id) {
        $query = "SELECT course_id, title, description, image_preview, category_id 
                  FROM Course 
                  WHERE course_id = :id";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_STR); // Change to PDO::PARAM_STR for string IDs
    } else {
        $query = "SELECT course_id, title, description, image_preview, category_id
                  FROM Course";
        $stmt = $db->prepare($query);
    }

    $stmt->execute();
    $courses = $stmt->fetchAll(PDO::FETCH_ASSOC); // Fetch all courses

    // Prepare an array to hold the final output with category names
    $output = [];

    // Loop through courses to get the category names
    foreach ($courses as $course) 
	{
        // Fetch the category name from the Category table based on main_category_name
        $categoryQuery = "SELECT name AS category_name 
                          FROM Category 
                          WHERE id = :category_id";
        $categoryStmt = $db->prepare($categoryQuery);
        $categoryStmt->bindParam(':category_id', $course['category_id'], PDO::PARAM_STR);
        $categoryStmt->execute();
        $categoryResult = $categoryStmt->fetch(PDO::FETCH_ASSOC);

        // Append course data along with the category name to the output array
        $output[] = [
            "course_id" => $course['course_id'],
            "title" => $course['title'],
            "description" => $course['description'],
            "image_preview" => $course['image_preview'],
            "category_id" => $course['category_id'],
            "category_name" => $categoryResult['category_name'] ?? null // Get category name
        ];
    }

    // Return the final output in JSON format
    if (count($output) > 0) {
        echo json_encode($output);
    } else {
        echo json_encode(["message" => "No courses found."]);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
