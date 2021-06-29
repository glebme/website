import React from 'react';
import {Switch, Route, BrowserRouter, Redirect} from 'react-router-dom';
import {Home} from './pages/Home'
import {About} from './pages/About'
import {Experience} from './pages/Experience'
import {Contact} from './pages/Contact'

function App() {
  return (
    <BrowserRouter>
      <Switch>
          <Route exact={true} component={Home} path='/' />
          <Route component={About} path='/about' />
          <Route component={Experience} path='/experience' />
          <Route component={Contact} path='/contact' />
      </Switch>
    </BrowserRouter>
  );
}

export default App;
