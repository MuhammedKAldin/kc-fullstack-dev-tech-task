import logo from './logo.svg';
import './App.css';
import { Route, Routes , useLocation} from 'react-router-dom';
import React, { lazy , Suspense } from 'react';
import { SwitchTransition, CSSTransition } from 'react-transition-group';
import Home from './pages/Home';
import NotFound from './pages/NotFound';


const Category = lazy(() => import('./pages/Category'));

function App() {

  const location = useLocation();

return (
    <Suspense fallback={<h1>Loading...</h1>}>
      <SwitchTransition>
      <CSSTransition key={location.pathname} classNames="fade" timeout={300} unmountOnExit>          
            <Routes Location={location}>
              <Route path='/' element={<Home />} />
              <Route path='/category/:category' element={<Category />} />
              <Route path="/404" element={<NotFound />} />
              <Route path="*" element={<NotFound />} />
            </Routes>
        </CSSTransition>
      </SwitchTransition>
    </Suspense>
  );

}

export default App;
