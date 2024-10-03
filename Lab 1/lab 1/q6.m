

notename = {'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#'};
%song = {'A' 'A' 'E' 'E' 'F#' 'F#' 'E' 'E' 'D' 'D' 'C#' 'C#' 'B' 'B' 'A' 'A'};
song = {'C' 'D' 'E' 'C' 'F' 'E' 'F' 'E' 'D' 'D'};
for k1 = 1:length(song)
idx = strcmp(song(k1), notename);
songidx(k1) = find(idx);
end
dur = 0.3*8192;
songnote = [ ];
for k1 = 1:length(songidx)
songnote = [songnote; [notecreate(songidx(k1),dur) zeros(1,75)]'];
end
soundsc(songnote, 8192)

function [note] = notecreate(frq_no, dur)
note = sin(2*pi* [1:dur]/8192 * (440*2.^((frq_no-1)/12)));
end