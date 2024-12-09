<?php
// api/v1/getCoursesByCategory.php
declare(strict_types=1);

error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include_once '../config/database.php';

$database = new Database();
$db = $database->getConnection();

if ($db === null) {
    http_response_code(500);
    echo json_encode(["error" => "Database connection failed."]);
    exit;
}

try {
    // Check if an 'id' parameter (category ID) is provided in the GET request
    $category_id = isset($_GET['id']) ? $_GET['id'] : null;

    if ($category_id) {
        // Sanitize the id to ensure it's safe for use
        $category_id = filter_var($category_id, FILTER_SANITIZE_SPECIAL_CHARS);

        // Update the query to match courses by main_category_name
        $query = "SELECT course_id, title, description, image_preview, category_id
                  FROM Course 
                  WHERE category_id = :id";

        $stmt = $db->prepare($query);
        $stmt->bindParam(':id', $category_id, PDO::PARAM_STR); // Bind the parameter as a string
        $stmt->execute(); // Execute the prepared statement
        $courses = $stmt->fetchAll(PDO::FETCH_ASSOC); // Fetch all matching courses

        // If courses are found, return them in JSON format
        if ($courses) {
            echo json_encode($courses);
        } else {
            // If no courses are found, return an empty array
            echo json_encode([]);
        }
    } else {
        // If no category_id is provided, return an error
        http_response_code(400);
        echo json_encode(["error" => "Missing id parameter."]);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
