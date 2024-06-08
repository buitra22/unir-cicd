FROM python:3.6-slim

# Crear el directorio de trabajo
RUN mkdir -p /opt/calc

# Establecer el directorio de trabajo
WORKDIR /opt/calc

# Copiar los archivos de configuración y las dependencias
COPY .coveragerc .pylintrc pyproject.toml pytest.ini requires ./

# Copiar el código de la aplicación y los tests
COPY app ./app
COPY test ./test

# Instalar las dependencias
RUN pip install --upgrade pip
RUN pip install -r requires

# Establecer el PYTHONPATH y el comando por defecto para ejecutar los tests
ENV PYTHONPATH=/opt/calc

CMD ["pytest", "--cov=app", "--cov-report=xml:results/coverage.xml", "--cov-report=html:results/coverage", "--junit-xml=results/unit_result.xml"]


