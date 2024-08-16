close all
clear all
clc

x0 = [-2;-2];


x = TrustRegion(@(x) actual_func(x), @(x) model_func(x), x0, 0.15, 1e-4, 100, 0.5, 2);