% trigger delays

t1 = [694 908 583 718 456 614 394 576 390 607 847 556 801 535 745 ...
      471 706 440 650 428 584 286 557 350 480 166 380 621 407 589  ...
      324 586 379 535 237 482 268 424 100 338 71  229 957 170 437  ...
      178 335 158 373 178 315 105 312 117 357 169 411 144 407  95  ...
      308 499 182 446 187 344 124 384 125 361  79 338 928 137 673  ...
      837 439 659 822 680 840 324 595 10  150 976 195  72 280 216  ...
      405 332 497  26 236 399 850  95 745 874 243 377 498 758 614  ...
      876 763 1];
  
t2 = [747 963 633 782 502 670 438 639 442 659 909 612 862 581 798 ...
      518 767 486 702 472 639 342 626 394 545 214 431 681 451 651 ...
      370 654 424 590 292 543 312 479 148 399 117 285 1003 221 505 ...
      225 391 209 427 228 380 149 366 167 419 221 471 189 475 143 ...
      361 561 230 514 232 400 168 453 171 422 122 407 973 191 725 ...
      891 493 709 876 728 895 380 664 63 215 1031 249 115 334 268 ...
      468 386 553  70 288 455 905 155 789 939 290 442 543 824 661 ...
      943 810 61];
    
v  = [14  42  14  53  15  53  14  47  1   7   54  7   48  6   70  ...
      6   65  6   52  6   54  7   69  6   46  2   9   50  9   56  ...
      8   46  8   52  8   45  9   70  8   39  9   40  2   9   38  ...
      8   49  8   38  9   65  9   37  9   44  8   64  9   57  1   ...
      7   52  6   47  7   63  7   39  7   38  7   66  7   68  6   ...
      56  3   11  52  10  71  10  46  10  47  10  59  10  57  10  ...
      72  10  40  4   13  42  12  70  13  59  12  58  12  52  ...
      13  45  13  57];

plot((t2-t1),v,'linestyle','none','marker','o')
hold on
line([40 80],[6 6])
line([40 80],[7 7])
line([40 80],[8 8])
line([40 80],[9 9])
axis([0 100 0 100])

[x6,y6] = find(v == 6);
[x7,y7] = find(v == 7);
[x8,y8] = find(v == 8);
[x9,y9] = find(v == 9);
[x10,y10] = find(v == 10);
[x11,y11] = find(v == 11);
[x12,y12] = find(v == 12);
[x13,y13] = find(v == 13);
[x14,y14] = find(v == 14);
[x15,y15] = find(v == 15);

[x,y] = find(v > 20);

T = (t2-t1);
mean(T([y6 y7 y8 y9 y10 y11 y12 y13 y14 y15]))
mean(T([y]))

