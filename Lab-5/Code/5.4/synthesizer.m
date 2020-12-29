function y = synthesizer(A,F_notes,P,adsr,td_notes,fs)

y = [];

% Loop over the notes
for ii = 1:length(F_notes)
    
 % scale a,d,sd,r so that they sum to required note duration
 a=adsr(1)*td_notes(ii);
 d=adsr(2)*td_notes(ii);
 s=adsr(3)*td_notes(ii);
 sd=adsr(4)*td_notes(ii);
 r=adsr(5)*td_notes(ii);
 
 % Compute the time vector and ADSR envelope for this note
 [t,env] = envelope(a,d,s,sd,r,fs);
 
 % Compute the sum of harmonics for this note
 xt = harmonics(A, F_notes(ii), P, td_notes(ii), fs);
 
 % Modulate the sum of harmonics with the envelope
 xte=zeros(length(xt),1);
 for k=1:length(xt)
     xte(k) = xt(k)*env(k);
 end

 % Add the note to the sequence
 y = cat(1,y,xte);
 
end

end