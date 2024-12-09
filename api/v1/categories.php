<?php
// api/v1/getCategories.php
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

/**
 * Get the course count for a category and its children.
 *
 * @param string $categoryId The ID of the category.
 * @param PDO $db The PDO database connection.
 * @return int The total number of courses in the category and its children.
 */
function getCoursesCount(string $categoryId, PDO $db): int {
    // Count the courses directly assigned to this category
    $query = "SELECT COUNT(*) AS courses_count 
              FROM course 
              WHERE category_id = :category_id";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':category_id', $categoryId, PDO::PARAM_STR);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    
    // Start with the direct count
    $totalCount = (int)$result['courses_count'];

    // Now sum the counts of child categories
    $childQuery = "SELECT id 
                   FROM Category 
                   WHERE parent = :category_id";
    $childStmt = $db->prepare($childQuery);
    $childStmt->bindParam(':category_id', $categoryId, PDO::PARAM_STR);
    $childStmt->execute();
    $children = $childStmt->fetchAll(PDO::FETCH_ASSOC);

    // Recursively count courses in child categories
    foreach ($children as $child) {
        $totalCount += getCoursesCount($child['id'], $db);
    }

    return $totalCount;
}

try {
    // Check if an 'id' parameter is provided
    $id = isset($_GET['id']) ? $_GET['id'] : null;

    // If 'id' is provided, get the specific category; otherwise, get all categories
    if ($id) {
        $query = "SELECT id, name, parent
                  FROM Category 
                  WHERE id = :id";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':id', $id, PDO::PARAM_STR);
    } else {
        $query = "SELECT id, name, parent
                  FROM Category";
        $stmt = $db->prepare($query);
    }

    $stmt->execute();
    $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (count($categories) > 0) {
        // For each category, calculate the courses_count
        foreach ($categories as &$category) {
            $category['courses_count'] = getCoursesCount($category['id'], $db);
        }
        echo json_encode($categories);
    } else {
        echo json_encode(["message" => "No categories found."]);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => $e->getMessage()]);
}
