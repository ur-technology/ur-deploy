var kickOffOldClients = function() {
  var count = 0;
  var peers = admin.peers;
  for (var i = 0; i < peers.length; i++) {
    var peer = peers[i];
    if (!/e2bfd4d9/.test(peer.name)) {
      console.log("removed old peer", JSON.stringify(peer));
      admin.removePeer(peer.id);
      count++;
    }
  }
  console.log("removed " + count + "peers");
}
kickOffOldClients();

// var kickOffOldClientsRepeatedly = function() {
//   kickOffOldClients();
//   if (count % 360 === 0) { // roughly every 3 minutes
//     console.log("scanning for old clients...")
//   }
//   count++;
//   setTimeout(kickOffOldClientsRepeatedly, 0.5 * 1000);
// };
// kickOffOldClientsRepeatedly();
