import csv
import re

from pix2text import Pix2Text
from pix2text.ocr_engine import prepare_ocr_engine
from pix2text.table_ocr import TableOCR
import os
from Functions.FormulaOCR.P2T.scripts import tably


def formula_OCR(img_path):
    p2t = Pix2Text.from_config()
    out = p2t.recognize_formula(img_path)
    return out

def table_OCR(img_path):
    os.environ['HF_ENDPOINT'] = os.getenv('HF_ENDPOINT', 'https://hf-mirror.com')
    languages = ('en', 'ch_sim')
    text_ocr = prepare_ocr_engine(languages, {})
    ocr = TableOCR.from_config(text_ocr=text_ocr)
    result = ocr.recognize(
        img_path,
        out_csv=True,
        out_cells=False,
        out_objects=False,
        out_html=False,
        out_markdown=False,
    )
    str = result.get("csv")[0]
    data = str.split('\r\n')

    with open('../buffer.csv', 'w', newline='') as file:
        writer = csv.writer(file)
        for i in data:
            writer.writerow(re.sub('(,)(?=(?:[^"]|"[^"]*")*$)','|',i).split("|"))

    return tably.runner()

