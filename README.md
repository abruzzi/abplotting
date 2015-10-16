### Ab Gnuplot

This is a very simple tool for do the `benchmark` testing, by using this tool, you can 
simply define your `benchmark` in a `yml` file like this:

```yml
benchmark:
  description: "Benchmark of WFS with/without cache"
  number: 1000
  concurrent: 20

  tests:
    - name: single instance
      description: single instance
      url: http://192.168.3.11:8080/resources

    - name: squid with 2 instances
      description: squid with 2 instances
      url: http://192.168.3.15:8080/resources
```

and then run the ruby script `plot.rb`:

```sh
$ ruby plot.rb
```

after this command running successfully, some new files will be generated automatically:

-  `plot-script.g`, the gnuplot script to generate the final result `eps`(or `png`)
-  `benchmark,sh`, the shell script to run all the tests and invoke `gnuplot` to plot


#### requirements

-  [ab](https://httpd.apache.org/docs/2.2/programs/ab.html), Apache Benchmarking tool
-  [gnuplot](http://www.gnuplot.info/), Gnuplot is a portable command-line driven graphing utility

