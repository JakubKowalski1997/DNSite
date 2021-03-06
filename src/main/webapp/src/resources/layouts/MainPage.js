import React from "react";
import { Route, Switch } from "react-router-dom";
import Home from "../pages/Home";
import Supermasters from "../pages/Supermasters";
import Domains from "../pages/Domains";
import Domain from "../pages/Domain"
import Administration from "../pages/Administration";
import Records from "../pages/Records";
import ReactDOM from 'react-dom'
import Error404 from "../pages/Error404";
import HistoryPanel from "../pages/History";
import ChangePassword from "../pages/ChangePassword";
import LogoutHelper from "../pages/LogoutHelper";

const MainPage = () => {
  return (
    <>
      <Switch>
        <Route path="/" exact component={Home} />
        <Route path="/supermasters" component={Supermasters} />
        <Route path="/domains" component={Domains} />
        <Route path="/records" component={Records} />
        <Route path="/administration" component={Administration} />
        <Route path="/changePassword" component={ChangePassword} />
        <Route path="/history" component={HistoryPanel} />
        <Route path="/domain/:id" component={Domain}/>
        <Route path="/privacy-policy" component={LogoutHelper}/>
        <Route component={Error404} />
      </Switch>
    </>
  );
};

ReactDOM.render(MainPage, document.getElementById('root'))

export default MainPage;
