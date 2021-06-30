export enum HeaderLinkType {
    Home = 'Home',
    About = 'About',
    Experiences = 'Experiences',
    Contact = 'Contact'
};

export interface HeaderLink {
    title: string;
    link: string;
};

export const headerLinkMap: {[key: string]: HeaderLink} = {
    [HeaderLinkType.Home]: {
        title: HeaderLinkType.Home,
        link: '/'
    },
    [HeaderLinkType.About]: {
        title: HeaderLinkType.About,
        link: '/about'
    },
    [HeaderLinkType.Experiences]: {
        title: HeaderLinkType.Experiences,
        link: '/experience'
    },
    [HeaderLinkType.Contact]: {
        title: HeaderLinkType.Contact,
        link: '/contact'
    },
};

export const getNavLinks = (): HeaderLinkType[] => {
    return [
        HeaderLinkType.About,
        HeaderLinkType.Experiences,
        HeaderLinkType.Contact
    ];
};