importScripts("https://www.gstatic.com/firebasejs/10.0.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.0.0/firebase-messaging-compat.js");

// Initialize Firebase
firebase.initializeApp({
    apiKey: "AIzaSyCjcVQALd71MnMEEE8owg7AGCv-dco3sNY",
    authDomain: "e-commerece-f7d89.firebaseapp.com",
    projectId: "e-commerece-f7d89",
    storageBucket: "e-commerece-f7d89.appspot.com",
    messagingSenderId: "635663434875",
    appId: "1:635663434875:web:80fad9ea285e6264d4cede",
    measurementId: "G-JHM1PBZ75Z"
});

// Retrieve an instance of Firebase Messaging
const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
    console.log("[firebase-messaging-sw.js] Received background message:", payload);
    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
        icon: "/firebase-logo.png",
    };

    self.registration.showNotification(notificationTitle, notificationOptions);
});
