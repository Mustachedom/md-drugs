import { writable } from "svelte/store";

interface playerItems  {
    item: string;
    amount: number;
}

interface drugStocks {
    item: string;
    label: string;
    image: string;
    amount: number;
}

interface Employee {
    name: string;
    role: string;
    Stats: {
        speed: number;
        quality: number;
        consistency: number;
    };
    salary: number;
}

let cokeItems: Array<drugStocks> = [
    {item: 'bakingsoda', label: 'Baking Soda', image: '/public/bakingsoda.png', amount: 20},
    {item: 'coca_leaf', label: 'Coca Leaf', image: '/public/coca_leaf.png', amount: 10},
    {item: 'coke', label: 'Raw Cocaine', image: '/public/coke.png', amount: 5},
    {item: 'cokestagetwo', label: 'Cocaine Stage 2', image: '/public/cokestagetwo.png', amount: 3},
    {item: 'cokestagethree', label: 'Cocaine Stage 3', image: '/public/cokestagethree.png', amount: 1},
    {item: 'loosecoke', label: 'Loose Cocaine', image: '/public/loosecoke.png', amount: 8},
    {item: 'loosecokestagetwo', label: 'Loose Cocaine Stage 2', image: '/public/loosecokestagetwo.png', amount: 6},
    {item: 'loosecokestagethree', label: 'Loose Cocaine Stage 3', image: '/public/loosecokestagethree.png', amount: 6},
    {item: 'cokebag', label: 'Cocaine Bag', image: '/public/cocaine_baggy.png', amount: 5},
    {item: 'cokebagstagetwo', label: 'Cocaine Bag Stage 2', image: '/public/cocaine_baggystagetwo.png', amount: 2},
    {item: 'cokebagstagethree', label: 'Cocaine Bag Stage 3', image: '/public/cocaine_baggystagethree.png', amount: 1},
    {item: 'empty_bag', label: 'Empty Bag', image: '/public/weed_baggy_empty.png', amount: 10},
];

let playerStock: Array<playerItems> = [
    {item: 'bakingsoda', amount: 15},
    {item: 'coca_leaf', amount: 25},
    {item: 'coke', amount: 0},
    {item: 'cokestagetwo', amount: 1},
    {item: 'cokestagethree', amount: 0},
    {item: 'cokebag', amount: 10},
    {item: 'cokebagstagetwo', amount: 5},
    {item: 'cokebagstagethree', amount: 2},
    {item: 'empty_bag', amount: 30},
];

let hiredEmployees: Array<Employee> = [
     {name: 'John Doe', role: 'Break Down', Stats: {speed: 5, quality: 7, consistency: 6}, salary: 250},
     {name: 'Jane Smith', role: 'Cutting', Stats: {speed: 6, quality: 5, consistency: 7}, salary: 275},
];

let availableEmployees: Array<Employee> = [
    {name: 'Mike Johnson', role: 'Packaging', Stats: {speed: 7, quality: 6, consistency: 5}, salary: 300},
];

export const visibility = writable(false);
export const playerItems = writable<playerItems[] | null>(playerStock);
export const drugStocks = writable<drugStocks[] | null>(cokeItems);
export const employees = writable<Array<Employee> | null>(hiredEmployees);
export const hireable = writable<Array<Employee> | null>(availableEmployees);
export const jobRole = [
    'Break Down',
    'Cutting',
    'Packaging',
]