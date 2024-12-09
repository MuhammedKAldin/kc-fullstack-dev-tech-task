import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import ParagraphLimit from '../components/ParagraphLimit';

const Home = () => {
    const BaseUrl = 'http://api.cc.localhost'; // Updated Base URL
    const URL1 = `${BaseUrl}/categories.php`; // Side Links Category Tree & Content Counts
    const URL2 = `${BaseUrl}/courses.php`; // Displays All Courses

    const [cats, setCats] = useState([]);
    const [courses, setCourses] = useState([]);

    useEffect(() => {
        const categoriesData = async () => {
            try {
                const result = await fetch(URL1);
                const json = await result.json();
                setCats(json);
            } catch (error) {
                console.error('Error fetching categories:', error);
            }
        };

        const coursesData = async () => {
            try {
                const result = await fetch(URL2);
                const json = await result.json();
                setCourses(json);
            } catch (error) {
                console.error('Error fetching courses:', error);
            }
        };

        categoriesData();
        coursesData();
    }, []);

    const renderChildCategories = (parentId) => {
        const children = cats.filter((cat) => cat.parent === parentId);

        if (children.length === 0) {
            // No children, return nothing
            return null;
        }

        // Recursively render any sub-children
        return (
            <ul>
                {children.map((child) => (
                    <li key={child.id}>
                        <Link to={`/category/${child.id}`}>{child.name}</Link>
                        <span className="count-content">
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
                <h1 className="headline text-center">Course catalog</h1>
            </header>

            <div className="container text-center">
                <div className="row">
                    <div className="col-md-3 text-left categories">
                        <ul>
                            {cats.length > 0 && (
                                <li>
                                    <span className="badge bg-warning home-marker"> | </span>
                                    <Link to={`/`}>
                                        <span id="home-category">Home</span>
                                    </Link>
                                </li>
                            )}

                            {cats
                                .filter((cat) => cat.parent === null)
                                .map((cat) => (
                                    <li key={cat.id} className="btn-primary position-relative">
                                        <Link to={`/category/${cat.id}`}>{cat.name}</Link>
                                        <span className="count-content">
                                            {cat.courses_count > 0 ? ` (${cat.courses_count})` : null}
                                        </span>
                                        {renderChildCategories(cat.id)}
                                    </li>
                                ))}
                        </ul>
                    </div>

                    <div className="col-md-9">
                        <div id="coursesPanel" className="row">
                            {courses.map((course) => {
                                return (
                                    <div className="col course" key={course.course_id}>
                                        <div className="card">
                                            <span className="badge bg-secondary corner">
                                                {course.category_name}
                                            </span>
                                            <div className="card-body">
                                                <img className="card-img-top thumbnail" src={course.image_preview} alt={course.title} />
                                                <b class="course-title">{course.title}</b>
                                                <ParagraphLimit text={course.description} limit={100} />
                                            </div>
                                        </div>
                                    </div>
                                );
                            })}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Home;
