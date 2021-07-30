#!/usr/bin/node

var mathId = "6515-63910-06114";

function f1(n, byte, c) {
  for (var bitIndex = 0; bitIndex <= 7; bitIndex++) {
    var bit = (byte >> bitIndex) & 1;
    if (bit + ((n - bit) & ~1) === n) {
      n = (n - bit) >> 1;
    } else {
      n = ((c - bit) ^ n) >> 1;
    }
  }
  return n;
}

function genPassword(str, hash) {
  for (var byteIndex = str.length - 1; byteIndex >= 0; byteIndex--) {
    hash = f1(hash, str.charCodeAt(byteIndex), 0x105c3);
  }
  var n1 = 0;
  while (f1(f1(hash, n1 & 0xff, 0x105c3), n1 >> 8, 0x105c3) !== 0xa5b6) {
    if (++n1 >= 0xffff) {
      return "Error";
    }
  }
  n1 = Math.floor((((n1 + 0x72fa) & 0xffff) * 99999.0) / 0xffff);
  var n1str = ("0000" + n1.toString(10)).slice(-5);
  var temp = parseInt(
    n1str.slice(0, -3) + n1str.slice(-2) + n1str.slice(-3, -2),
    10
  );
  temp = Math.ceil((temp / 99999.0) * 0xffff);
  temp = f1(f1(0, temp & 0xff, 0x1064b), temp >> 8, 0x1064b);
  for (byteIndex = str.length - 1; byteIndex >= 0; byteIndex--) {
    temp = f1(temp, str.charCodeAt(byteIndex), 0x1064b);
  }
  var n2 = 0;
  while (f1(f1(temp, n2 & 0xff, 0x1064b), n2 >> 8, 0x1064b) !== 0xa5b6) {
    if (++n2 >= 0xffff) {
      return "Error";
    }
  }
  n2 = Math.floor(((n2 & 0xffff) * 99999.0) / 0xffff);
  var n2str = ("0000" + n2.toString(10)).slice(-5);
  return (
    n2str[3] +
    n1str[3] +
    n1str[1] +
    n1str[0] +
    "-" +
    n2str[4] +
    n1str[2] +
    n2str[0] +
    "-" +
    n2str[2] +
    n1str[4] +
    n2str[1] +
    "::1"
  );
}

function checkMathId(s) {
  if (s.length != 16) return false;
  for (let i = 0; i < s.length; i++) {
    if (i === 4 || i === 10) {
      if (s[i] !== "-") return false;
    } else {
      if ("0123456789".search(s[i]) < 0) return false;
    }
  }
  return true;
}

function genActivationKey() {
  s = "";
  for (let i = 0; i < 14; i++) {
    s += Math.floor(Math.random() * 10);
    if (i === 3 || i === 7) s += "-";
  }
  return s;
}

Array.prototype.getRandom = function () {
  return this[Math.floor(Math.random() * this.length)];
};

// Mathematica 12.0, 12.1, 12.2, 12.3
var magicNumbers = [
  10690, 12251, 17649, 24816, 33360, 35944, 36412, 42041, 42635, 44011, 53799,
  56181, 58536, 59222, 61041,
];

console.log(checkMathId(mathId));

var activationKey = genActivationKey();
var password = genPassword(
  mathId + "$1&" + activationKey,
  magicNumbers.getRandom()
);
console.log(activationKey);
console.log(password);
