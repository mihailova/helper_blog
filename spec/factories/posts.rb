# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    sequence :title do |n|
      "title#{n}"
    end

    text <<EOF;
<b>Lorem</b> ipsum Elit in sunt ad in eu aute qui irure quis cillum irure laboris 
officia et sunt Duis eu irure Excepteur nisi dolore dolor ex sed ea quis 
adipisicing ad labore Duis in commodo fugiat occaecat nostrud incididunt 
adipisicing cupidatat ullamco eu in elit aliquip tempor dolor eu voluptate id 
magna pariatur ut et dolor consectetur culpa incididunt irure id nostrud adipisicing 
ea dolor eiusmod ut nisi dolore cupidatat nisi Ut in laboris labore irure veniam 
pariatur sunt quis laborum cillum consectetur non voluptate cillum do qui eu aute 
Ut in irure in nisi ea ex ullamco incididunt ad Duis in culpa Excepteur labore 
et in ea deserunt aliqua consectetur sit culpa dolor amet do aliqua aliqua sit 
labore pariatur commodo fugiat laboris mollit ullamco minim sunt anim nulla deserunt 
deserunt exercitation amet culpa pariatur dolor amet cillum sed in minim dolore labore 
do do laboris sed tempor id incididunt deserunt magna Duis non et irure magna sed anim 
aute Excepteur ea mollit reprehenderit in velit sunt dolore laboris non veniam eiusmod 
minim do Duis cillum laborum Excepteur anim nostrud irure eiusmod aliquip aliqua in 
nulla anim sed proident esse irure aliquip velit dolore id in Duis sunt ut culpa ex 
dolore enim amet tempor ut do pariatur minim ea et ut id in et aute velit commodo eu 
exercitation ullamco ea esse cillum do consequat exercitation minim dolor ut 
consectetur tempor mollit.

Lorem ipsum Elit in sunt ad in eu aute qui irure quis cillum irure laboris 
officia et sunt Duis eu irure Excepteur nisi dolore dolor ex sed ea quis 
adipisicing ad labore Duis in commodo fugiat occaecat nostrud incididunt 
adipisicing cupidatat ullamco eu in elit aliquip tempor dolor eu voluptate id 
magna pariatur ut et dolor consectetur culpa incididunt irure id nostrud adipisicing 
ea dolor eiusmod ut nisi dolore cupidatat nisi Ut in laboris labore irure veniam 
pariatur sunt quis laborum cillum consectetur non voluptate cillum do qui eu aute 
Ut in irure in nisi ea ex ullamco incididunt ad Duis in culpa Excepteur labore 
et in ea deserunt aliqua consectetur sit culpa dolor amet do aliqua aliqua sit 
labore pariatur commodo fugiat laboris mollit ullamco minim sunt anim nulla deserunt 
deserunt exercitation amet culpa pariatur dolor amet cillum sed in minim dolore labore 
do do laboris sed tempor id incididunt deserunt magna Duis non et irure magna sed anim 
aute Excepteur ea mollit reprehenderit in velit sunt dolore laboris non veniam eiusmod 
minim do Duis cillum laborum Excepteur anim nostrud irure eiusmod aliquip aliqua in 
nulla anim sed proident esse irure aliquip velit dolore id in Duis sunt ut culpa ex 
dolore enim amet tempor ut do pariatur minim ea et ut id in et aute velit commodo eu 
exercitation ullamco ea esse cillum do consequat exercitation minim dolor ut 
consectetur tempor mollit.
EOF

    tags 'new'
    private false
    created_at {Time.now}
    association :user, factory: :user
  end
end
