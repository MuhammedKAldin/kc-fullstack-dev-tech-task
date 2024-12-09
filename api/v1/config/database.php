<?php

class Database {
    private $host = "db";  // docker-compose
    private $database_name = "course_catalog"; // docker-compose
    private $username = "test_user";  // docker-compose
    private $password = "test_password";  // docker-compose
    private $port = "3306"; // docker-compose

    public $conn;

    public function getConnection(){
        $this->conn = null;
        try{
            $this->conn = new PDO(
                "mysql:host=" .$this->host . ";
                port=" . $this->port. ";
                dbname=" .$this->database_name,
                $this->username,
                $this->password
            );
        }catch(PDOException $exception){
            echo "Database could not be connected: " .$exception->getmessage();
        }
        return $this->conn;
    }
}