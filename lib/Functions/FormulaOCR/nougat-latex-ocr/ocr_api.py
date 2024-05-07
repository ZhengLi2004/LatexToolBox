import uvicorn
import signal
import os
from fastapi import FastAPI
import queue
from examples.run_latex_ocr import run_nougat_latex

app = FastAPI()
q = queue.Queue()
server = uvicorn.Server(uvicorn.Config(app))
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

@app.post("/shutdown")
def shutdown():
    pid = os.getpid()
    os.kill(pid, signal.SIGINT)

if __name__  == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)