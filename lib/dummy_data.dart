import './models/food_model.dart';
import './models/donator_model.dart';

const DUMMY_FOODS = const [
  Food(
    id: 'f1',
    name: 'Fright Rice',
    image: 'https://i.ytimg.com/vi/PNpVCrIlnPg/maxresdefault.jpg',
    available: '20',
    donatorId: 'd1',
    donator: 'US Hotels',
    donatorRating: 5,
    location: 'Jaffna',
  ),
  Food(
    id: 'f2',
    name: 'Noodles',
    image:
        'https://1.bp.blogspot.com/-VHvXydZxFmA/XpFd73m4GjI/AAAAAAAARKA/FkiRpKMnAVodpITwKXED8DIfkMPcrQFowCLcBGAsYHQ/s1600/Teriyaki-Noodles-1.jpg',
    available: '38',
    donatorId: 'd2',
    donator: 'Rolex',
    donatorRating: 3,
    location: 'Colombo',
  ),
  Food(
    id: 'f3',
    name: 'Pasta',
    image: 'https://sparkpeo.hs.llnwd.net/e4/nw/7/9/l790811918.jpg',
    available: '15',
    donatorId: 'd1',
    donator: 'Green Grass',
    donatorRating: 4,
    location: 'Jaffna',
  ),
  Food(
    id: 'f4',
    name: 'Rice and Curry',
    image:
        'https://www.knorr.lk/Images/2809/2809-863142-the-art-of-sri-lankan-cooking-580x326.jpg',
    available: '25',
    donatorId: 'd2',
    donator: 'Selva Restaurant',
    donatorRating: 2,
    location: 'Kokuvil',
  ),
];

const DUMMY_DONATORS = const [
  Donator(
    id: 'd1',
    name: 'US Hotels',
    location: 'Jaffna',
    mobile: '0762596548',
    url: 'https://www.uplist.lk/wp-content/uploads/2019/06/US-Hotel-Jaffna.jpg',
  ),
  Donator(
    id: 'd2',
    name: 'Green Grass Wedding Hall',
    location: 'Jaffna',
    mobile: '0762596548',
    url: 'https://pbs.twimg.com/media/Dvb7IB3XQAA0BGn.jpg',
  ),
  Donator(
    id: 'd3',
    name: 'Roldvsdv sdvsdvsdvw dsadasd',
    location: 'Jaffna',
    mobile: '0762596548',
    url: 'https://www.uplist.lk/wp-content/uploads/2019/06/US-Hotel-Jaffna.jpg',
  ),
];
