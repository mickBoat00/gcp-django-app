from accounts.forms import UserCreationForm
from accounts.models import User
from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response


def index(request):
    # users = User.objects.count()
    users = 10
    return render(request, 'index.html', {'user_count': users})

def second(request):
    # users = User.objects.count()
    users = 15
    return render(request, 'second.html', {'user_count': users})


@api_view(['POST'])
def sign_up_user(request):

    data = request.data

    print('data', data)

    form = UserCreationForm(
        data={
            "email": data['email'],
            "password1": data['password1'],
            "password2": data['password2'],
            "user_type": data['user_type']
        }
    )

    if not form.is_valid():
        return Response(data={"failed": "User created failed!"}, status=409)
    
    form.save()
    
    return Response(data={"success": "User created sucessfully!"}, status=201)


