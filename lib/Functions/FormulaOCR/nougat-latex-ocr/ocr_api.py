from fastapi import FastAPI
import queue
from examples.run_latex_ocr import run_nougat_latex

app = FastAPI()

q = queue.Queue()

@app.get("/outputQueue")
def outputQueue():
    if (q.empty() == False):
        return q.get()
    else:
        return {"Response": ""}

@app.post("/inputQueue/{file_path}")
def inputQueue(file_path: str):
    file_path = file_path.replace('+', "\\\\")
    q.put({"Response": run_nougat_latex(file_path)})