export type Result = {
    correct: boolean;
    message: string;
}

export interface ResultEvaluator {
    evaluate(): Result;
}

export function nextInt(min: number, max: number) {
    return Math.floor(min + Math.random() * (max - min));
}

export function pickOne<T>(values: T[]): T {
    return values[nextInt(0, values.length)];
}
