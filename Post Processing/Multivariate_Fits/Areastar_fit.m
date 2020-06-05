function Areastar = Areastar_fit(k, L, E)
    Areastar = (-24500.0633551108) + 3.4039965126005 * E + 39.4089312962124 * L ...
                + (E - 1133.1914893617) * ((L - 574.468085106383) * 0.0218367908901855) + 61597.4266960705 * k ...
                + (L - 574.468085106383)* ((k - 0.595744680851063) * 154.927286967572) + -0.0360804393085448 * (L .* L) ...
                + (E-1133.1914893617) * ((L .* L - 438297.872340426) * -0.0000184417338842378)...
                + (k-0.595744680851063) * ((L .* L - 438297.872340426) * -0.116470460061714);
   
end