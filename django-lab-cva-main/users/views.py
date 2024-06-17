# users/views.py

from django.contrib.auth import login
from django.shortcuts import redirect, render
from django.urls import reverse
from django.contrib.auth import get_user_model
from users.forms import *

def dashboard(request):
    if request.method == "POST":
        form = UploadFileForm(request.POST, request.FILES)
        if form.is_valid():
            with open(".images/"+request.FILES["file"].name, "wb+") as destination:
                for chunk in request.FILES["file"].chunks():
                    destination.write(chunk)
            return redirect(reverse("dashboard"))
    else:
        form = UploadFileForm()
    return render(request, "users/dashboard.html", {"form": form})
        

def register(request):
    if request.method == "GET":
        return render(
            request, "users/register.html",
            {"form": CustomUserCreationForm}
        )
    elif request.method == "POST":
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect(reverse("dashboard"))
        return redirect(reverse("error"))
    
def error(request):
    return render(request, "users/error.html")



def facelogin(request):
    if request.method == "GET":
        return render(
            request, "users/facelogin.html",
            {"form": FaceDetectLoginForm}
        )
    elif request.method == "POST":
        form = FaceDetectLoginForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            if True:
                pass
                # Do face recognition here
            User = get_user_model()
            user = User.objects.get(username=username)
            login(request, user)
            return redirect(reverse("dashboard"))
        return redirect(reverse("error"))
