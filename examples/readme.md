# Examples

This folder includes several examples

|name|description|
|---|---|
|BMICalculator.purs|Example to calculate body mass index (BMI) using custom slider components.
|Counter.purs|Example to increment a counter by clicking buttons.|
|CounterStore.purs|Increment a counter by using `store pattern `as described in chapter ["Managing state"](https://outwatch.github.io/managing-state.html?lang=purescript)|

### Build and run

1. install dependencies

```shell
npm install
```

2. compile example you want to run

```shell
npm run build:example-counter
npm run build:example-counter-store
npm run build:example-bmi-calculator
```

3. start a static webserver and visite the `examples/dist` folder

```shell
python3 -m http.server 8080 # example
```
