importScripts('https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js');

firebase.initializeApp({
    apiKey: "AIzaSyABHz-f5DpHbYj7g9FN0ge7kcblWKzvgDg",
    authDomain: "sis-tm.firebaseapp.com",
    projectId: "sis-tm",
    storageBucket: "sis-tm.appspot.app",
    messagingSenderId: "993855769329",
    appId: "1:993855769329:web:381d7f693563786d3a3750",
    measurementId: "G-56NLKHJ4LK",
});

const messaging = firebase.messaging();
