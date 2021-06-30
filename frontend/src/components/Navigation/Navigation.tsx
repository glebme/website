import React from 'react';

import Navbar from 'react-bootstrap/Navbar';
import Nav from 'react-bootstrap/Nav';
import Container from 'react-bootstrap/Container';

import { getNavLinks, headerLinkMap, HeaderLinkType } from './NavigationOptions';

const navLinks = getNavLinks();

const Navigation = () => {
  return (
    <Navbar expand='lg' fixed='top'>
      <Container>
        <Navbar.Collapse>
          <Nav
            activeKey="/"
          >
            {navLinks.map((linkType: HeaderLinkType) => {
              const {title, link} = headerLinkMap[linkType];
              return (
                <Nav.Item>
                  <Nav.Link href={link}>{title}</Nav.Link>
                </Nav.Item>
              );
            })}
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
};

export {Navigation};