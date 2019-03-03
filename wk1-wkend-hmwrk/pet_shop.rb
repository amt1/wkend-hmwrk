def pet_shop_name(pet_shop)
 return pet_shop[:name]
end

def total_cash(pet_shop)
  return pet_shop[:admin][:total_cash]
end

def add_or_remove_cash(pet_shop, amount)
  pet_shop[:admin][:total_cash]+=amount
  return pet_shop[:admin][:total_cash]
end

def pets_sold(pet_shop)
  return pet_shop[:admin][:pets_sold]
end

def increase_pets_sold(pet_shop, number_sold)
  pet_shop[:admin][:pets_sold]+=number_sold
end

def stock_count(pet_shop)
  return pet_shop[:pets].length()
end

def pets_by_breed(pet_shop, breed_name)
  pets_found=Array.new()
  for pet in pet_shop[:pets]
    pets_found << pet if pet[:breed]==breed_name
  end
  return pets_found
end

def find_pet_by_name(pet_shop, name)
# both the function and test function assume pet names are unique
  pet_found=nil
  for pet in pet_shop[:pets]
    return pet if pet[:name]==name
  end
  return pet_found
end

def remove_pet_by_name(pet_shop, name)
    pet_shop[:pets].delete_if {|pet| pet[:name]==name}
end

def add_pet_to_stock( pet_shop, pet)
  pet_shop[:pets] << pet
end

def customer_cash(customer)
  return customer[:cash]
end

def remove_customer_cash(customer, amount)
  return customer[:cash]-=amount
end

def customer_pet_count(customer)
  return customer[:pets].length
end

def add_pet_to_customer(customer, pet)
  customer[:pets]<<pet
end

def customer_can_afford_pet(customer, pet)
  return ( customer[:cash]>=pet[:price])
end

def sell_pet_to_customer(pet_shop,pet,customer)
  return "Pet not found" if pet == nil
    if customer_can_afford_pet(customer,pet)
      remove_customer_cash(customer, pet[:price])
      add_or_remove_cash(pet_shop, pet[:price])
      remove_pet_by_name(pet_shop, pet[:name])
      add_pet_to_customer(customer, pet)
      increase_pets_sold(pet_shop, 1)
    else return "This customer can't afford this pet"
    end # end if
end # end def
