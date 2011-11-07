/*

Copyright (C) 2011 Francesco Balestrieri

This file is part of Stopwatch - a simple stopwatch for Nokia N9

Stopwatch is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Stopwatch is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Stopwatch.  If not, see <http://www.gnu.org/licenses/>.

*/
var suspendTime = null

function zeroPad(n) {

    return (n < 10 ? "0" : "") + n

}

function toTime(msec) {

    var mod = Math.abs(msec)
    return (msec < 0 ? "-" : "") +
            (mod >= 36000 ? Math.floor(mod / 36000) + ':' : '') +
            zeroPad(Math.floor((mod % 36000) / 600)) + ':' +
            zeroPad(Math.floor((mod % 600) / 10)) + '.' +
            mod % 10
}

function toDelta(msec) {

    var mod = Math.abs(msec)
    var hours = Math.floor(mod / 36000)
    var minutes = Math.floor((mod % 36000) / 600)
    var seconds = Math.floor((mod % 600) / 10)
    var mseconds = mod % 10

    var result = msec < 0 ? "-" : "+"
    if (hours > 0)
        result += hours + ":"
    if (minutes > 0)
        result += (hours > 0 ? zeroPad(minutes) : minutes) + ":"
    result += (minutes > 0 ? zeroPad(seconds) : seconds) + "." + mseconds

    return result
}
