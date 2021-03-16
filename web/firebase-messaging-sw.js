//importScripts("https://www.gstatic.com/firebasejs/8.3.0/firebase-app.js");
//importScripts("https://www.gstatic.com/firebasejs/8.3.0/firebase-messaging.js");
importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyCpn16IzmQe4Tr7glln1tp9UkL44DrSvC8",
    authDomain: "pushnotificationapp-602ed.firebaseapp.com",
    databaseURL: "https://pushnotificationapp-602ed-default-rtdb.firebaseio.com",
    projectId: "pushnotificationapp-602ed",
    storageBucket: "pushnotificationapp-602ed.appspot.com",
    messagingSenderId: "678961155053",
    appId: "1:678961155053:web:a63cf3922afe657d0735e4",
    measurementId: "G-67N67S72GB"
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});