@ECHO off
set /p user=Digite o seu login para entrar na rede do open lab: 
OscGroupClient 146.164.9.237 22242 22241 22243 22244 %user% 123 hiper4 nano
