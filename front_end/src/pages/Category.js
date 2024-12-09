import { Link, useNavigate } from 'react-router-dom';
import ParagraphLimit from '../components/ParagraphLimit';
import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

const Category = () => {
  const { category } = useParams();
  const Base_Url = "http://api.cc.localhost"; // Updated Base URL
  const URL1 = `${Base_Url}/categories.php`; // Side Links Category Tree & Content Counts
  const URL2 = `${Base_Url}/category/courses.php?id=${category}`; // Return Category's Courses
  const URL3 = `${Base_Url}/categories.php?id=${category}`; // Title of Category Page


  const [cats, setCats] = useState([]);
  const [courses, setCourses] = useState([]); // Initialize as empty array
  const [currentCat, setCurrentCat] = useState(""); // Initialize as empty string
  const navigate = useNavigate(); 

  useEffect(() => {
    const categories_Data = async () => {
      const result = await fetch(URL1);
      result.json().then(json => {
        setCats(json);
      });
    };

    const courses_Data = async () => {
      const result = await fetch(URL2);
      const json = await result.json();

      // Check if json is an array before setting state
      if (Array.isArray(json)) {
        setCourses(json);
      } else {
        console.error('Courses data is not an array:', json);
        // Optionally reset to empty if not an array
        setCourses([]); 
      }
    };

    const current_Category = async () => {
      try {
        const result = await fetch(URL3);
        
        if (!result.ok) {
          throw new Error('Network response was not ok');
        }

        const json = await result.json();
        
        if (json.length === 0) {
          navigate("/404");
        } else {
          setCurrentCat(json[0].name);
        }
      } catch (error) {
        console.error('Error fetching current category:', error);
        navigate("/404"); 
      }
    };

    categories_Data();
    courses_Data();
    current_Category();
  }, [navigate]); // Add navigate to dependency array

  const renderChildCategories = (parentId) => 
  {
    const children = cats.filter(cat => cat.parent === parentId);
    
    if (children.length === 0) 
    {
      // No children, return nothing
      return null; 
    }
  
    {/* Recursively render any sub-children */}
    return (
      <ul>
        {children.map(child => (
          <li key={child.id}>
            {currentCat == child.name && (
              <span class="badge bg-warning marker"> | </span>
            )}
            <Link to={`/category/${child.id}`}>{child.name}</Link>
            <span class="count-content" > 
              {child.courses_count > 0 ? ` (${child.courses_count})` : null}
            </span> 
            {renderChildCategories(child.id)}
          </li>
        ))}
      </ul>
    );
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1 className='headline text-center'>
          {currentCat || "Loading..."}
        </h1>
      </header>

      <div className="container text-center categories">
        <div className="row">
          <div className="col-md-3 text-left">
            <ul class="categories">

              {cats.length > 0 && (
                <li>
                  <Link to={`/`}>
                    <span id="home-category">Home</span>
                  </Link>
                </li>
              )}

              {cats.filter(cat => cat.parent === null).map(cat => (
                <li key={cat.id}>
                  {currentCat == cat.name && (
                  <span class="badge bg-warning marker"> | </span>
                  )}
                  <Link to={`/category/${cat.id}`}>{cat.name}</Link>
                      <span class="count-content" > 
                        {cat.courses_count > 0 ? ` (${cat.courses_count})` : null}
                      </span> 
                     {renderChildCategories(cat.id)}
                </li>
              ))}
            </ul>
          </div>
          
          <div className="col-md-9">
            <div className="row">
                {cats.length > 0 && (
                  <>
                    {courses.length === 0 && currentCat != null ? (
                      // Check if courses is empty
                      <h1 id="no-courses-available">
                        No courses available for this category.
                      </h1>
                    ) : (
                      courses.map((course) => (
                        <div className="col course" key={course.course_id}>
                          <div className="card">
                            <span className="badge bg-secondary corner">{currentCat}</span>
                            <div className="card-body">
                              <img className="course-img card-img-top thumbnail"
                                src={course.image_preview}
                                alt={course.title}
                              />
                              <b class="course-title">{course.title}</b>
                              <ParagraphLimit text={course.description} limit={100} />
                            </div>
                          </div>
                        </div>
                      ))
                    )}
                  </>
                )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Category;
