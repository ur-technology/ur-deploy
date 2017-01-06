var kickOffOldClients = function() {
  var peers = admin.peers;
  for (var i = 0; i < peers.length; i++) {
    var peer = peers[i];
    if (!/e2bfd4d9/.test(admin.peers[0].name)) {
      console.log("removed old peer", JSON.stringify(peer));
      admin.removePeer(peer.id);
    }
  }
};

var count = 0;
var kickOffOldClientsRepeatedly = function() {
  kickOffOldClients();
  if (count % 1200 === 0) {
    console.log("scanning for old clients...")
  }
  count++;
  setTimeout(kickOffOldClientsRepeatedly, 0.5 * 1000);
};
kickOffOldClientsRepeatedly();
